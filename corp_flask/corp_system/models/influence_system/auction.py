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
    
    # Type of division for influence type
    division_id = db.Column(db.String(36), db.ForeignKey('division.id'), nullable=True)
    division = db.relationship('Division', backref='auctions', foreign_keys=[division_id], lazy=True)
    
    department_id = db.Column(db.String(36), db.ForeignKey('department.id'), nullable=True)
    department = db.relationship('Department', backref='auctions', foreign_keys=[department_id], lazy=True)
    
    # Iten that is being auctioned
    title = db.Column(db.String(32), nullable=False)
    description = db.Column(db.String(250), nullable=False)
    icon = db.Column(db.String(64), nullable=False, default='error')
    
    item_holder_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=False)
    item_holder = db.relationship('Inf_Account', backref='auctioned_items', foreign_keys=[item_holder_id], lazy=True)
    
    # Auction status
    highest_bidder_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=True)
    highest_bidder = db.relationship('Inf_Account', backref='auctions_purchases', foreign_keys=[highest_bidder_id], lazy=True)
    
    current_price = db.Column(db.Integer, default=0)
    
    closed = db.Column(db.Boolean, default=False)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
    
        
    def delete(self):
        db.session.delete(self)
        db.session.commit()



