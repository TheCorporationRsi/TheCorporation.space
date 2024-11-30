from datetime import datetime, timedelta

from corp_system import db

from .. import Base

from sqlalchemy import and_

from sqlalchemy.orm import backref
import json


class Inf_Account(Base):
    __tablename__ = "inf_account"

    last_tribute_time = db.Column(db.DateTime, default=datetime.now())
    
    tribute_amount = db.Column(db.Integer, default=0)
    
    RSI_handle = db.Column(db.String(32), unique=True, nullable=True)

    user_id = db.Column(db.String(36), db.ForeignKey('user.id'), nullable=True)
    user = db.relationship('User', backref=backref('inf_account', uselist=False, lazy=True), lazy=True)
    
    # Inf_Account.influences
    
    rank_id = db.Column(db.String(36), db.ForeignKey('inf_rank.id'), nullable=True)
    rank = db.relationship("Inf_Rank", backref='accounts', foreign_keys=[rank_id], lazy=True)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        if self.user:
            self.RSI_handle = self.user.RSI_handle
        
        from corp_system.models import Inf_Rank
        self.rank_id = Inf_Rank.query.filter_by(title='Corporateer').first().id
        
        db.session.commit()
    
    def use_influence(self, amount, department=None, division=None):
        
        if self.current_influence(department=department, division=division) < amount:
            return False
        
        left = amount
        from corp_system.models import Influence

        while left > 0:
            if division:
                influence = Influence.query.filter(and_(Influence.account==self, Influence.division==division, Influence.division_influence==True, Influence.amount > 0)).order_by(Influence.created_at).first()
            elif department:
                influence = Influence.query.filter(and_(Influence.account==self, Influence.department==department, Influence.department_influence==True, Influence.amount > 0)).order_by(Influence.created_at).first()
            else:
                influence = Influence.query.filter(and_(Influence.account==self, Influence.amount > 0)).order_by(Influence.created_at).first()

            if influence.amount >= left:
                influence.amount -= left
                left = 0
            else:
                left -= influence.amount
                influence.amount = 0
                
        db.session.commit()
    
    def add_influence(self, amount, department=None, division=None):
        
        from corp_system.models import Influence
        influence = Influence(account=self, amount=amount, department=department, division=division)
        
        db.session.add(influence)
        db.session.commit()
    
    def lifetime_influence(self, division=None, department=None, general=False):
        count = 0
        
        if general:
            for influence in self.influences:
                    if influence.department == None and influence.division == None:
                        count += influence.initial_amount
        else:
            if division:
                for influence in self.influences:
                    if influence.division == division:
                        count += influence.initial_amount
            elif department:
                for influence in self.influences:
                    if influence.department == department:
                        count += influence.initial_amount
            else:
                for influence in self.influences:
                    count += influence.initial_amount
            
        return count

    def current_influence(self, division=None, department=None, general=False):
        count = 0
        if general:
            for influence in self.influences:
                if not influence.department_influence:
                    count += influence.amount
        else:
            if division:
                for influence in self.influences:
                    if influence.division == division and influence.division_influence:
                        count += influence.amount
            elif department:
                for influence in self.influences:
                    if influence.department == department and influence.department_influence:
                        count += influence.amount
            else:
                for influence in self.influences:
                    count += influence.amount
            
        return count
    
    def current_influence_on_bets(self, division=None, department=None):
        if division:
            return sum([bet.current_price for bet in self.auctions_purchases if (not bet.prize_claimed and bet.division == division)])
        elif department:
            return sum([bet.current_price for bet in self.auctions_purchases if (not bet.prize_claimed and bet.department == department)])
        else:
            return sum([bet.current_price for bet in self.auctions_purchases if not bet.prize_claimed])

    def get_weight_dict(self):
        from corp_system.models import Division
        divisions = Division.query.all()
        member_divisions = self.user.divisions
        member_divisions_ids = [division.id for division in self.user.divisions]
        weights = [division.get_weight(self.user) for division in self.user.divisions]
        
        dictionary = dict(zip(member_divisions_ids, weights))
        return json.dumps(dictionary)
    
    def update(self):
        
        if self.user:
            self.RSI_handle = self.user.RSI_handle
            
        if (datetime.now() - self.last_tribute_time) >= timedelta(weeks=1):
            self.tribute_amount = min(1.5 * self.rank.weekly_amount, self.tribute_amount + self.rank.weekly_amount)
            self.last_tribute_time = datetime.now()
        
        from corp_system.models import Inf_Rank
        self.rank = db.session.query(Inf_Rank).filter(Inf_Rank.required_lifetime_influence <= self.lifetime_influence()).order_by(Inf_Rank.required_lifetime_influence.desc()).first()
        
        db.session.commit()
    
    def as_dict(self):
        return {
            'id': self.id,
            'influence_points': self.current_influence(),
            'last_tribute_updated': self.last_tribute_time,
            'user_id': self.user_id
        }
    
    