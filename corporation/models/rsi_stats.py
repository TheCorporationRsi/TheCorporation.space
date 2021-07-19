from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash
from sqlalchemy import or_
from corporation.data.scraping import RSI_account


class Funding(db.Model):
    __bind_key__ = 'rsi_stats_db'
    id = db.Column(db.Integer, primary_key=True)
    date = db.Column(db.DateTime, nullable=False, unique=True, default=datetime.utcnow)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    
    fund = db.Column(db.Integer, nullable=False )
    citizens = db.Column(db.Integer, nullable=False)
    
    
    def as_dict(self):
        return {
            'Date': self.date,
            'Fund': self.fund,
            'Citizens': self.citizens
        }

    def __repr__(self):
        return f"Funding('{self.date}', '{self.fund}', '{self.citizen}')"
    