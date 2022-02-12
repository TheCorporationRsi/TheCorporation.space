from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from sqlalchemy.orm import backref
from project import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash
from sqlalchemy import or_
import uuid
from sqlalchemy.dialects.postgresql import UUID

from project.models import Base

class Transaction(Base):
    __tablename__ = "transaction"
    
    user_from_id =  db.Column(db.Text(length=36), db.ForeignKey('user.id'))
    user_to_id = db.Column(db.Text(length=36), db.ForeignKey('user.id'))

    user_from = db.relationship("User", foreign_keys=user_from_id, back_populates="sender_transactions")
    user_to = db.relationship("User", foreign_keys=user_to_id, back_populates="receiver_transactions")

    method = db.Column(db.String(32), nullable=False, default='unknown')
    amount = db.Column(db.Integer, nullable=False, default=0)
    
    message = db.Column(db.Text, nullable=True)
    div_list = db.Column(db.JSON, nullable=True)

class Influence(Base):
    __tablename__ = "influence"

    division_id = db.Column(db.Text(length=36), db.ForeignKey('division.id'), nullable=True)
    department_id = db.Column(db.Text(length=36), db.ForeignKey('department.id'), nullable=True)
    
    division = db.relationship("Division", backref=db.backref("influences", uselist=False), lazy=True)
    department = db.relationship("Department", backref=db.backref("influences"), foreign_keys=[department_id], lazy=True)

    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

    amount = db.Column(db.Integer, default=0)

    lifetime_amount = db.Column(db.Integer, nullable=False, default=0)

    def __repr__(self):
        return f"Influence('{self.title}')"



class Influence_rank(Base):
    __tablename__ = "influence_rank"

    title = db.Column(db.String(32), unique=True, nullable=False)
    required_influence = db.Column(db.Integer, unique=True, nullable=False, default=0)
    weekly_amount = db.Column(db.Integer, unique=True, nullable=False, default=50)


    def member_count(self):
        ...
        # return Influence_account.query.filter_by(rank=self.id).count()

    def __repr__(self):
        return f"Rank('{self.title}', '{self.date_added}')"




