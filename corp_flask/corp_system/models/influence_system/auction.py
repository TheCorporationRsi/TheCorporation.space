
from datetime import datetime

from corp_system import db

from .. import Base

from sqlalchemy import and_

from sqlalchemy.orm import backref
import json



class Inf_Auction(Base):
    __tablename__ = "inf_auction"
    
    # Auction active time
    start_time = db.Column(db.DateTime, default=datetime.now())
    end_time = db.Column(db.DateTime, nullable=False)
    
    # Auction 
    starting_price = db.Column(db.Integer, nullable=False, default=0)
    bets = db.Column(db.JSON, default=[])  # Storing list of bets as JSON
    
    # Type of division for influence type
    division_id = db.Column(db.String(36), db.ForeignKey('division.id'), nullable=True)
    division = db.relationship('Division', backref='auctions', foreign_keys=[division_id], lazy=True)
    
    department_id = db.Column(db.String(36), db.ForeignKey('department.id'), nullable=True)
    department = db.relationship('Department', backref='auctions', foreign_keys=[department_id], lazy=True)
    
    # Iten that is being auctioned
    item = db.Column(db.Text, nullable=False)
     
    item_holder_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=False)
    item_holder = db.relationship('Inf_Account', backref='auctioned_items', foreign_keys=[item_holder_id], lazy=True)
    
    # Auction status
    highest_bidder_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=True)
    highest_bidder = db.relationship('Inf_Account', backref='auctions_purchases', foreign_keys=[highest_bidder_id], lazy=True)
    
    current_price = db.Column(db.Integer, default=0)
    prize_claimed = db.Column(db.Boolean, default=False)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        self.current_price = self.starting_price-1
    
    def bet(self, amount, user):
        
        if datetime.now() > self.end_time:
            raise ValueError('Auction has already ended')
        
        if amount <= self.current_price:
            raise ValueError('Bet amount is nit high enough')
        
        if (user.inf_account.current_influence(division=self.division, department=self.department) - user.inf_account.current_influence_on_bets(division=self.division, department=self.department)) < amount:
            raise ValueError('User does not have enough influence left of this type to bet')
        
        self.highest_bidder = user.inf_account
        self.current_price = amount
        self.bets.append({
            'account_id': user.inf_account.id,
            'amount': amount
        })
        
        db.session.commit()
    
    def claim_prize(self):
        
        if datetime.now() < self.end_time:
            raise ValueError('Auction has not ended')
        
        self.highest_bidder.inf_account.use_influence(amount=self.current_price, division=self.division, department=self.department)
        self.prize_claimed = True
        
        db.session.commit() 
        
    def delete(self):
        db.session.delete(self)
        db.session.commit()
    
