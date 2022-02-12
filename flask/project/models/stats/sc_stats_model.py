from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from sqlalchemy.orm import query
from project import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash
from sqlalchemy import or_

from project.models import Base




class Funding(Base):
    __bind_key__ = 'rsi_stats_db'
    __tablename__ = "funding"
    
    date = db.Column(db.DateTime, nullable=False, unique=True, default=datetime.utcnow)
    
    fund = db.Column(db.Integer, nullable=False )
    citizens = db.Column(db.Integer, nullable=False)
    
    
    def as_dict(self):
        return {
            'Date': self.date.strftime('%d/%m/%Y %H:%M:%S %Z'),
            
        }

    def __repr__(self):
        return f"Funding('{self.date}', '{self.fund}', '{self.citizen}')"