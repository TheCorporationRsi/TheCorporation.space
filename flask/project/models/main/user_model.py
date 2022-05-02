from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from sqlalchemy.orm import backref
from project import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash
from sqlalchemy import or_
from sqlalchemy.ext.hybrid import hybrid_property
import uuid

from project.models import Base, Influence_rank, Influence, Role
from project.models.main.user_methods.influence_method import influence_methods

import secrets

import project.api.bots.controller as bot_controller

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)

@login_manager.request_loader
def load_user(request):
    token = request.headers.get('auth_token', None)
    password = request.headers.get('password', None)
    if not token or not password:
        return None
    
    user = User.query.filter_by(api_token = token).first()
    if user and user.test_password(password):
        return user
    else:
        return None

from project.models.main.user_methods import influence_methods, role_methods, security_methods, UserRole
class User(Base, UserMixin, influence_methods, role_methods, security_methods):
    __tablename__ = "user"
    
    # User info
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    RSI_moniker = db.Column(db.String(32), nullable=True)
    RSI_number = db.Column(db.Integer, nullable=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    _password = db.Column("password", db.String(60))
    image_file = db.Column(db.String(20), default='default.jpg')
    
    previous_handles = orgs = db.Column(db.JSON, nullable=False, default= {
        'handle_change': []
    })

    # Linked account
    discord_username = db.Column(db.String(32), unique=True, nullable=True)
    discord_id = db.Column(db.String(32), unique=True, nullable=True)

    guilded_username = db.Column(db.String(32), unique=False, nullable=True)
    guilded_id = db.Column(db.String(32), unique=True, nullable=True)

    # Security level
    login_attempt = db.Column(db.Integer, nullable=False, default=0)
    security = db.Column(db.Integer, nullable=True)
    email_confirmed = db.Column(db.Boolean, default=False)
    registered = db.Column(db.Boolean, default=False)
    
    RSI_confirmed = db.Column(db.Boolean, default=False)
    verification_token = db.Column(db.Text(length=42), unique=True, default=lambda: str(secrets.token_urlsafe(42)))
    
    corp_confirmed = db.Column(db.Boolean, default=False)
    
    api_token = db.Column(db.Text(length=256), unique=True, default=lambda: str(secrets.token_urlsafe(256)))
    
    # Roles section
    roles = db.relationship('Role', secondary="user_role", lazy='subquery', backref=db.backref('members', lazy='dynamic', passive_deletes=True), cascade="all, delete")

    # Influence section
    tribute = db.Column(db.Integer, nullable=False, default=0)
    last_payment = db.Column(db.DateTime, nullable=False, default=datetime.utcnow())

    rank_id = db.Column(db.Text(length=36), db.ForeignKey('influence_rank.id'))
    rank = db.relationship("Influence_rank", backref=db.backref('members'))

    general_influence = db.Column(db.Integer, nullable=False, default=0)
    lifetime_influence_total = db.Column(db.Integer, nullable=False, default=0)
    influences = db.relationship('Influence')

    orgs = db.Column(db.JSON, nullable=False, default= {
        'main_org': {},
        'orgs': []
    })

    sender_transactions = db.relationship('Transaction', foreign_keys='[Transaction.user_from_id]', back_populates="user_from")
    receiver_transactions = db.relationship('Transaction', foreign_keys='[Transaction.user_to_id]', back_populates="user_to")
    

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        rank = Influence_rank.query.filter_by(title= "Corporateer").first()
        if not rank:
            rank = Influence_rank(title= "Corporateer", required_influence = 0, weekly_amount= 50)
            db.session.add(rank)
            db.session.commit()
        self.rank = rank
        db.session.commit()


    @hybrid_property
    def password(self):
        return 'NiceTry'

    @password.setter
    def password(self, password):
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
        self._password = hashed_password
        db.session.commit()
    
    '''
    Methods
    '''
    
    def send_dm(self, message):
        bot_controller.send_dm(self, message)

    def update_info(self):
        from project.api.scraping.RSI.account import RSI_account
        
        if self.RSI_handle == "Cyber-Dreamer" and self.RSI_confirmed:
            self.security = 5
            db.session.commit()
        
        
        RSI_info = RSI_account(RSI_handle=self.RSI_handle)
        corp_role = Role.query.filter_by(type='Corporateer').first()
        if not corp_role:
            corp_role = Role(title="Corporateer", color="blue", type='Corporateer')
            db.session.add(corp_role)
            db.session.commit()
            
        if RSI_info != -1:

            self.orgs['orgs'] = RSI_info.as_json()['Orgs']
            self.orgs['main_org']['title'] = RSI_info.main_org

            if self.RSI_confirmed:
                self.RSI_moniker = RSI_info.Moniker
                self.RSI_number = RSI_info.citizen
                self.RSI_handle = RSI_info.RSI_handle
                if RSI_info.corp_member():
                    self.add_role(corp_role)
                    self.corp_confirmed = True
                else:
                    self.remove_role(corp_role)
                    self.corp_confirmed = False
                if self.corp_confirmed:
                    self.update_rank()
                    self.update_tribute()
                bot_controller.change_nickname(self, self.RSI_handle)
                    
            elif RSI_info.confirm_token(self.verification_token):
                self.RSI_confirmed = True
                self.corp_confirmed = False
                self.remove_role(corp_role)
                self.update_info()
        elif RSI_account(RSI_handle="Cyber-Dreamer") != -1:
            self.RSI_confirmed = False
            
        db.session.commit()

    def update_discord_roles(self):
        all_roles = Role.query.all()
        if self.discord_id is not None:
            socketio.emit('change_nickname', {'member_id': self.discord_id, 'nickname': self.RSI_handle}, namespace='/discord_bot')
            for role in all_roles:
                if not role.discord_id == 0 and not role.discord_id == None:
                    if self.has_role(role):
                        socketio.emit('add_role', {'user': self.discord_id, 'role_id': role.discord_id}, namespace='/discord_bot')
                    else:
                        socketio.emit('delete_role', {'user': self.discord_id, 'role_id': role.discord_id}, namespace='/discord_bot')
    
    def upload_discord_roles(self):
        if self.discord_id is not None:
            socketio.emit('upload_roles', {'user': self.discord_id}, namespace='/discord_bot')
    

    def as_dict(self):
        return {
            'id': self.id,
            'RSI_handle': self.RSI_handle,
            'RSI_moniker': self.RSI_moniker,
            'registered': self.registered,
            'email': self.email,
            'Discord': {
                "id": self.discord_id,
                "username": self.discord_username
            }, 
            'Guilded': {
                "id": self.guilded_id,
                "username": self.guilded_username
            }, 
            'corp_confirmed': self.corp_confirmed,
            'Guilded': {
                "id": self.guilded_id,
                "username": self.guilded_username
            },
            'Guilded': {
                "id": self.guilded_id,
                "username": self.guilded_username
            },
            'roles': [role.as_dict() for role in self.roles]
        }
        
    def as_dict_public(self):
        return {
            'RSI_handle': self.RSI_handle,
            'RSI_moniker': self.RSI_moniker,
            'Discord': {
                "username": self.discord_username
            }, 
            'Guilded': {
                "username": self.guilded_username
            }, 
            'corp_confirmed': self.corp_confirmed
        }
        
    def as_dict_private(self):
        
        return {
            'id': self.id,
            'RSI_handle': self.RSI_handle,
            'RSI_moniker': self.RSI_moniker,
            'registered': self.registered,
            'email': self.email,
            'Discord': {
                "id": self.discord_id,
                "username": self.discord_username
            }, 
            'Guilded': {
                "id": self.guilded_id,
                "username": self.guilded_username
            }, 
            'corp_confirmed': self.corp_confirmed,
            'Guilded': {
                "id": self.guilded_id,
                "username": self.guilded_username
            }
        }

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"