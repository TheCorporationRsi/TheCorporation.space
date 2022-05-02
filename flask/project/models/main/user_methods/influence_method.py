from project import db
from project.models import Influence, Influence_rank, Transaction
from datetime import datetime, timedelta

class influence_methods:

    def lifetime_influence(self, entity=None):

        division = None
        department = None
        match entity.__class__.__name__:
            case "Department":
                department = entity
            case "Division":
                department = entity.department
                division = entity

        count = 0
        if entity is None:
            return self.lifetime_influence_total

        influence = Influence.query.filter_by(user_id= self.id, department= department, division = division).first()
        if influence:
            return influence.lifetime_amount 
        else: 
            return 0

    
    def influence(self, entity=None):
        division = None
        department = None
        match entity.__class__.__name__:
            case "Department":
                department = entity
            case "Division":
                department = entity.department
                division = entity
        
        count = self.general_influence
        if entity is None:
            for influence in self.influences:
                count += influence.amount
            return count
            
        influence = Influence.query.filter_by(user_id= self.id, department= department, division = division).first()
        if influence:
            return influence.amount 
        else: 
            return 0

    def update_rank(self):
        self.rank = Influence_rank.query.filter(Influence_rank.required_influence <= self.lifetime_influence_total).order_by(Influence_rank.required_influence.desc()).first()


    def update_tribute(self):
        self.update_rank()
        next_friday = self.last_payment + timedelta( (4-self.last_payment.weekday()) % 7 )
        while(next_friday < datetime.utcnow()):
            self.tribute += self.rank.weekly_amount
            self.last_payment = next_friday + timedelta(days=1)
            next_friday = self.last_payment + timedelta( (4-self.last_payment.weekday()) % 7 )

        if self.tribute > 1.5*self.rank.weekly_amount:
            self.tribute = 1.5*self.rank.weekly_amount

    def remove_influence(self, amount, entity=None):
        division = None
        department = None
        match entity.__class__.__name__:
            case "Department":
                department = entity
            case "Division":
                department = entity.department
                division = entity

        if not division and not department and self.general_influence >= amount:
            self.general_influence -= amount
            return

        influence = Influence.query.filter_by(user_id= self.id, department= department, division = division).first()

        if influence and influence.amount >= amount:
            influence.amount -= amount
            db.session.commit()

            

    def add_influence(self, amount, entity=None, lifetime_only=False):
        division = None
        department = None
        match entity.__class__.__name__:
            case "Department":
                department = entity
            case "Division":
                department = entity.department
                division = entity

        if not division and not department:
            self.general_influence += amount
            self.lifetime_influence_total += amount
            db.session.commit()
            return
            
        influence = Influence.query.filter_by(user_id= self.id, department= department, division = division).first()
        if influence:
            if lifetime_only:
                influence.lifetime_amount += amount
            else:
                influence.amount += amount
                influence.lifetime_amount += amount
            db.session.commit()
        else:
            if lifetime_only:
                influence = Influence(user_id= self.id, department= department, division = division, amount = 0, lifetime_amount = amount)
            else:
                influence = Influence(user_id= self.id, department= department, division = division, amount = amount, lifetime_amount = amount)
            db.session.add(influence)
            db.session.commit()

        if department and division:
            self.add_influence(amount, department, lifetime_only=True)
        else:
            self.lifetime_influence_total += amount
                

    
    def send_tribute(self, receiver, amount, message="none", method="unknown"):
        if self.tribute < amount:
            return -1
        
        if receiver == self:
            return
        
        if not self.corp_confirmed or not self.RSI_confirmed or not receiver.corp_confirmed or not receiver.RSI_confirmed:
            return -1

        divisions = []
        departments_division = []
        
        for role in self.roles:
            if role.division and role.division not in divisions:
                if receiver.is_member(role.division):
                    divisions.append(role.division)
                else:
                    if role.division not in departments_division and receiver.is_member(role.division.department):
                        departments_division.append(role.division)

        total_sender_weight = 0
        for group in [divisions, departments_division]:
            for division in group: 
                total_sender_weight += self.get_weight(division)

        total_receiver_weight = 0
        for group in [divisions, departments_division]:
            for division in group: 
                total_receiver_weight += receiver.get_weight(division)

        self.tribute -= amount        

        if total_receiver_weight == 0 or total_sender_weight == 0:
            self.add_influence(amount = amount)
            receiver.add_influence(amount = amount)
            div_json = {}
            transaction = Transaction(user_from = self, user_to = receiver, amount = amount, method= method , message= message, div_list = div_json)
            db.session.add(transaction)
            db.session.commit()
            return 1

        div_json = {}
        div_json["divisions"] = []
        div_json["departments"] = []
        
        for division in divisions:
            ratio = ( ( (self.get_weight(division) / total_sender_weight) + (receiver.get_weight(division) / total_receiver_weight))/2 )
            value = amount * ratio
            self.add_influence(value, division,)
            receiver.add_influence(value, division)
            div_json["divisions"].append({
                'title': division.title,
                'id': division.id,
                'amount': value,
                'ratio': ratio
            })

        for division in departments_division:
            value = amount * ( ( (self.get_weight(division) / total_sender_weight) + (receiver.get_weight(division) / total_receiver_weight))/2 )
            self.add_influence(value, division.department)
            receiver.add_influence(value, division.department)
            div_json["departments"].append({
                'title': division.title,
                'id': division.id,
                'dep_id': division.department.id,
                'dep_title': division.department.title,
                'amount': value,
                'ratio': ratio
            })

        transaction = Transaction(user_from = self, user_to = receiver, amount = amount, method= method , message= message, div_list = div_json)
        db.session.add(transaction)
        db.session.commit()
        
        return 1

        