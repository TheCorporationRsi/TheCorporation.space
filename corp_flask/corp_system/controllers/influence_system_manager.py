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
        # Create a new rank with the given title and requirements
        if not re.match("^[a-zA-Z0-9-_]*$", title):
            raise ValueError("Title contain unallowed character")
        
        existing_rank = Inf_Rank.query.filter_by(title=title).first()
        if existing_rank:
            raise ValueError("A rank with this title already exists")
        
        rank = Inf_Rank(title=title, required_lifetime_influence=required_lifetime_influence, weekly_amount=weekly_amount)
        db.session.add(rank)
        db.session.commit()
        return rank

    @staticmethod
    def edit_rank(rank_title, title=None, required_lifetime_influence=None, weekly_amount=None):
        # Edit an existing rank's fields by title
        rank = Inf_Rank.query.filter_by(title=rank_title).first()
        if not rank:
            raise ValueError("Rank not found")
        if title is not None:
            if not re.match("^[a-zA-Z0-9-_]*$", title):
                raise ValueError("Title contain unallowed character")
            # Check for duplicate title
            existing_rank = Inf_Rank.query.filter_by(title=title).first()
            if existing_rank and existing_rank.id != rank.id:
                raise ValueError("A rank with this title already exists")
            rank.title = title
        if required_lifetime_influence is not None:
            rank.required_lifetime_influence = required_lifetime_influence
        if weekly_amount is not None:
            rank.weekly_amount = weekly_amount
        db.session.commit()
        return rank

    @staticmethod
    def delete_rank(rank_title):
        # Delete a rank by its title
        rank = Inf_Rank.query.filter_by(title=rank_title).first()
        if not rank:
            raise ValueError("Rank not found")
        db.session.delete(rank)
        db.session.commit()

    @staticmethod
    def create_auction(owner: User, item_name: str, description: str, end_time, department=None, division=None):
        from corp_system.models import Inf_Auction  # Import here to avoid circular import

        if not isinstance(item_name, str) or not item_name.strip():
            raise ValueError("Item name must be a non-empty string")
        if not isinstance(description, str) or not description.strip():
            raise ValueError("Description must be a non-empty string")
        if end_time is None:
            raise ValueError("End time must be provided")
        if len(item_name) > 32:
            raise ValueError("Item name too long (max 32 characters)")
        if len(description) > 250:
            raise ValueError("Description too long")
        if not re.match(r"^[a-zA-Z0-9 \-]*$", item_name):
            raise ValueError("Item name must be alphanumeric, spaces, or hyphens only")
        if not re.match("^[a-zA-Z0-9 .,?!]*$", description):
            raise ValueError("Description contains unallowed character")

        auction = Inf_Auction(
            title=item_name,
            description=description,
            end_time=end_time,
            department=department,
            division=division,
            item_holder=owner.inf_account,  # Assuming owner has an Inf_Account
        )
        db.session.add(auction)
        db.session.commit()
        return auction
    
    @staticmethod
    def place_bid(user: User, auction_id: str, bid_amount: int):
        from corp_system.models import Inf_Auction, Inf_AuctionBet  # Use Inf_AuctionBet instead of Inf_Bid

        # Validate input
        if not user or not isinstance(user, User):
            raise ValueError("User must be provided and valid")
        if not isinstance(auction_id, str) or not auction_id:
            raise ValueError("Auction ID must be a non-empty string")
        if not isinstance(bid_amount, int) or bid_amount < 1:
            raise ValueError("Bid amount must be a positive integer")

        auction = db.session.get(Inf_Auction, auction_id)
        if not auction:
            raise ValueError("Auction not found")

        # Check auction end time
        if auction.end_time < datetime.now():
            ended_since = datetime.now() - auction.end_time
            raise ValueError(f"Auction has ended (ended {ended_since} ago)")

        # Check user influence (department/division if specified)
        if auction.division:
            available = user.inf_account.current_influence(department=auction.department, division=auction.division) - user.inf_account.current_influence_on_bets(department=auction.department, division=auction.division)
        elif auction.department:
            available = user.inf_account.current_influence(department=auction.department) - user.inf_account.current_influence_on_bets(department=auction.department)
        else:
            available = user.inf_account.current_influence() - user.inf_account.current_influence_on_bets()

        if available  < bid_amount:
            raise ValueError("Insufficient influence to place bid")

        # Check if bid is higher than current highest
        highest_bet = db.session.query(Inf_AuctionBet).filter_by(auction_id=auction.id).order_by(Inf_AuctionBet.amount.desc()).first()
        if highest_bet and bid_amount <= highest_bet.amount:
            raise ValueError("Bid must be higher than current highest bid")

        # Place bid
        bet = Inf_AuctionBet(
            account_id=user.inf_account.id,
            auction_id=auction.id,
            amount=bid_amount,
        )
        db.session.add(bet)
        db.session.commit()
        
        # Update auction's highest bidder and amount
        auction.highest_bidder_id = user.inf_account.id
        auction.current_price = bid_amount
        db.session.commit()

