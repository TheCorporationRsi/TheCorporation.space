from corp_system.models import Influence, User, Inf_Rank, UserRole, Inf_Tribute
from corp_system import db
from datetime import datetime, timedelta

from sqlalchemy import asc, func

import re


class InfluenceSystemManager:

    @staticmethod
    def update_accounts():
        # Add the given amount of tribute to the user's lifetime influence
        users = User.query.all()
        for user in users:
            user.inf_account.update()
            user.log("Inf_system", f'You account has been updated')

    @staticmethod
    def send_tribute(sender: User, receiver: User, amount: int, message: str=None, method: str=None):
        # Send the given amount of tribute from the sender to the recipient
        sender.update()
        receiver.update()
        
        if sender == receiver:
            raise ValueError("You cannot send yourself tribute")
        
        if not receiver:
            raise ValueError("Receiver missing")
        
        if not sender:
            raise ValueError("Sender missing")
        
        if not amount:
            raise ValueError("Amount missing")
        
        if not isinstance(amount, int):
            raise ValueError("Amount must be integer")
        
        if message is not None:
            if not isinstance(message, str):
                raise ValueError("Message must be string")
        
            if len(message) > 250:
                raise ValueError("Message too long")
            
            if not re.match("^[a-zA-Z0-9 .,?!'\"()&-]*$", message):
                raise ValueError("Message contain unallowed character")
            
        if receiver.CORP_confirmed is False:
            raise ValueError("Receiver not a CORP member")
        
        if sender.CORP_confirmed is False:
            raise ValueError("Sender not a CORP member")

        if sender.inf_account.tribute_amount < amount:
            raise ValueError("Sender does not have enough tribute")
        
        if amount < 1:
            raise ValueError("Amount must be greater than 0")
        
        sender.inf_account.tribute_amount -= amount
        
        transaction = Inf_Tribute(
            sender=sender.inf_account, 
            sender_influence = sender.inf_account.get_weight_dict(),
            receiver=receiver.inf_account, 
            receiver_influence = receiver.inf_account.get_weight_dict(),
            amount=amount,
            method=method,
            message=message
        )
        db.session.add(transaction)
        
        # Get common departments
        common_departments = [department for department in sender.departments if department in receiver.departments]
        common_departments.sort(key=lambda department: (department.get_weight(sender) + department.get_weight(receiver)), reverse=True)
        common_departments_total_weight = sum([department.get_weight(sender) for department in common_departments])
        if len(common_departments) == 0:
            # Giving general influence
            sender.inf_account.add_influence(amount=amount)
            receiver.inf_account.add_influence(amount=amount)
        else:
            # Spliting influence between the departments
            amount_left = amount
            departemental_split= []
            for index, department in enumerate(common_departments):
                if amount_left == 0:
                    continue
                if index < (len(common_departments) -1):
                    portion = max(1,round((department.get_weight(sender)/common_departments_total_weight + department.get_weight(sender)/common_departments_total_weight)/2 * amount))
                    departemental_split.append(portion)
                    amount_left -= portion
                else :
                    departemental_split.append(amount_left)
            
            # Get common divisions
            common_divisions = [division for division in sender.divisions if division in receiver.divisions]
            for amount, department in zip(departemental_split, common_departments):
                
                if amount == 0:
                    continue
                amount_left = amount
                common_department_divisions = [division for division in common_divisions if division in department.divisions]
                common_department_divisions.sort(key=lambda division: (division.get_weight(sender) + division.get_weight(receiver)), reverse=True)
                common_department_divisions_total_weight = sum([division.get_weight(sender) for division in common_department_divisions])
                
                if len(common_department_divisions) > 0:
                    # Spliting influence between the divisions
                    for index, division in enumerate(common_department_divisions):
                        if amount_left == 0:
                            continue
                        if index < (len(common_department_divisions) -1):
                            portion = max(1,round((division.get_weight(sender)/common_department_divisions_total_weight + division.get_weight(sender)/common_department_divisions_total_weight)/2 * amount))
                            sender.inf_account.add_influence(amount=portion, department=department, division=division)
                            receiver.inf_account.add_influence(amount=portion, department=department, division=division)
                            amount_left -= portion
                        else :
                            sender.inf_account.add_influence(amount=amount_left, department=department, division=division)
                            receiver.inf_account.add_influence(amount=amount_left, department=department, division=division)
                else:
                    # Giving departmental influence
                    sender.inf_account.add_influence(amount=amount, department=department)
                    receiver.inf_account.add_influence(amount=amount, department=department)
        
        sender.inf_account.update()
        receiver.inf_account.update()
        sender.log("Inf_system", f'You sent {amount} tribute to {receiver.RSI_handle}')
        receiver.log("Inf_system", f'{sender.RSI_handle} sent you {amount} tribute')
        
        
        db.session.commit()
    
    @staticmethod
    def update_influences():
        # Update influences based on age
        one_year_ago = datetime.now() - timedelta(days=365)
        two_years_ago = datetime.now() - timedelta(days=730)

        # Update division influences
        division_influences = Influence.query.filter(Influence.division_influence == True, Influence.created_at <= one_year_ago).all()
        for influence in division_influences:
            influence.division_influence = False

        # Update departmental influences
        departmental_influences = Influence.query.filter(Influence.department_influence == True, Influence.created_at <= two_years_ago).all()
        for influence in departmental_influences:
            influence.departmental_influence = False

        db.session.commit()
    
    @staticmethod
    def merge_old_influences():
        for user in User.query.all():
            # Query old influences
            old_influences = Influence.query.filter_by(division_influence=False, department_influence=False, account=user.inf_account).all()

            # Group by division and department
            groups = db.session.query(Influence.division, Influence.department, func.sum(Influence.amount), func.sum(Influence.initial_amount)).filter(Influence.id.in_([i.id for i in old_influences])).group_by(Influence.division, Influence.department).all()

            # Create new influences and delete old ones
            for division, department, total_amount, total_initial_amount in groups:
                new_influence = Influence(division=division, department=department, amount=total_amount, initial_amount=total_initial_amount, account=user.inf_account)
                db.session.add(new_influence)
                for influence in old_influences:
                    if influence.division == division and influence.department == department:
                        db.session.delete(influence)

            db.session.commit()
    
    @staticmethod
    def create_rank(title, required_lifetime_influence, weekly_amount):
        # Create a new department with the given name and leader
        
        if not re.match("^[a-zA-Z0-9-_]*$", title):
            raise ValueError("Title contain unallowed character")
        
        rank = Inf_Rank(title=title, required_lifetime_influence=required_lifetime_influence, weekly_amount=weekly_amount)
        db.session.add(rank)
        db.session.commit()
        
        