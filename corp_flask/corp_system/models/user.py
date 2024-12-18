from datetime import datetime, timedelta
from corp_system import db, jwt
import secrets
from flask_jwt_extended import get_jwt_identity, create_access_token, decode_token, get_jwt
from . import Base
import pyotp
from email.mime.text import MIMEText
import smtplib
import bcrypt
import json

from flask import current_app, jsonify, request
from corp_system.tools.scraping.rsi_account import RSI_account
from sqlalchemy.orm import backref

from sqlalchemy.orm.attributes import flag_modified

import re

@jwt.user_identity_loader
def user_identity_lookup(user : 'User'):
    """
    Callback function to get the user identity for JWT token.
    """
    
    return user.RSI_handle

@jwt.token_in_blocklist_loader
def check_if_token_is_revoked(jwt_header, jwt_payload: dict):
    jti = jwt_payload["jti"]
    print(jti)
    token_in_redis = Jwt_Blacklist.query.filter_by(jwt_token=jti).first()
    print(token_in_redis)
    return token_in_redis is not None

class Jwt_Blacklist(Base):
    __tablename__ = "jwt_blacklist"
    
    jwt_token = db.Column(db.String(60))
    
    def __repr__(self):
        return f"(Token: {self.jwt_token})"
    


@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    """
    Callback function to lookup the user based on JWT token.
    """
    
    # Check for API key in the headers
    api_key = request.headers.get('X-API-KEY')

    if api_key:
        # If an API key is present, look up the user based on the API key
        user = User.query.filter_by(api_key=api_key).first()

        # Check if the user exists, the API key is enabled, and the user account is enabled
        if user and user.api_key_enabled and not user.disabled:
            user.log("Security", f'Accessed {request.path} with API key')
            return user
        else:
            current_app.logger.info(f'Auth failure to {request.path} with API key')
            return None
    else:
        # If no API key is present, continue with JWT and CSRF verification
        identity = jwt_data["sub"]
        print(identity)
        user = User.query.filter_by(RSI_handle=identity).first()

        # Check if the user exists and the user account is enabled
        if user and not user.disabled:
            user.log("Security", f'Accessed {request.path} with JWT token')
            return user
        else:
            current_app.logger.info(f'Auth failure at {request.path} with JWT token')
            return None

'''      
@jwt.unauthorized_loader
def unauthorized_response(callback):
    return jsonify({"msg": "Missing or invalid token"}), 401

@jwt.expired_token_loader
def expired_token_response(callback):
    return jsonify({"msg": "Token has expired"}), 401
''' 

class User(Base):
    __tablename__ = "user"
    
    def __init__(self, **kwargs):
        """
        User constructor.
        """
        super().__init__(**kwargs)
        
        from corp_system.models import Inf_Account
        if Inf_Account.query.filter_by(user_id=self.id).first() is None:
            account = Inf_Account(user=self)
            db.session.add(account)
            db.session.commit()
    
    # User fields
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    RSI_moniker = db.Column(db.String(32), nullable=True)
    RSI_number = db.Column(db.Integer, nullable=True)
    image_link = db.Column(db.String(150), default='default.jpg')
    
    # Discord
    discord_id = db.Column(db.String(32), unique=True, nullable=True)
        
    # Confirmation fields
    RSI_confirmed = db.Column(db.Boolean, default=False)
    CORP_confirmed = db.Column(db.Boolean, default=False)

    # Verification tokens
    RSI_verification_token = db.Column(db.String(64), unique=True, default=lambda: str(secrets.token_urlsafe(42)))
    
    # Password Management
    _password_hash = db.Column(db.String(128), nullable=False)
    temporary_password = db.Column(db.Boolean, default=False)
    login_attempt = db.Column(db.Integer, nullable=False, default=0)
    last_attempt_time = db.Column(db.DateTime, nullable=True)
    
    @property
    def password(self):
        raise AttributeError('password: write-only field')
    
    @password.setter
    def password(self, password):
        
        if self.verify_password_requirements(password):
            self._password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    @staticmethod
    def verify_password_requirements(password):
        if not len(password) >= 8:
            raise ValueError("Password must be between 8 and 32 characters long.")
        
        return True

    def check_password(self, password):
        if self.login_attempt >= 5 and self.last_attempt_time and datetime.now() - self.last_attempt_time < timedelta(hours=1):
            self.login_attempt += 1
            self.last_attempt_time = datetime.now()
            return False

        if bcrypt.checkpw(password.encode('utf-8'), self._password_hash.encode('utf-8')):
            self.login_attempt = 0
            return True
        else:
            self.login_attempt += 1
            self.last_attempt_time = datetime.now()
            return False
    
    def reset_password_lock(self):
        self.login_attempt = 0
    
    # 2FA fields
    otp_secret = db.Column(db.String(32), nullable=True, default=lambda: pyotp.random_base32())
    Enabled_2FA = db.Column(db.Boolean, default=False)
    
    
    
    def generate_otp(self):
        return pyotp.TOTP(self.otp_secret).now()
    
    def get_totp_uri(self):
        return pyotp.totp.TOTP(self.otp_secret).provisioning_uri(name=self.RSI_handle, issuer_name='TheCorporation')
    
    def verify_otp(self, otp):
        return pyotp.TOTP(self.otp_secret).verify(otp)
    
    # JWT
    
    auth_tokens = db.Column(db.JSON, nullable=False, default=[])
    
    def save_token(self, token):
        
        decoded_token = decode_token(token)
        jti = decoded_token.get("jti")
        exp = decoded_token.get("exp")
        
        self.auth_tokens.append({
            'jti':jti,
            'exp':exp
        })
        flag_modified(self, "auth_tokens")
        
        db.session.commit()
    
    def disconnect(self):
        for token in self.auth_tokens:
            blacklist = Jwt_Blacklist(jwt_token=token['jti'])
            self.auth_tokens.remove(token)
            db.session.add(blacklist)
        flag_modified(self, "auth_tokens")
        db.session.commit()
        
    def logout(self):
        jti = get_jwt()["jti"]
        blacklist = Jwt_Blacklist(jwt_token=jti)
        for token in self.auth_tokens:
            if token["jti"] == jti:
                self.auth_tokens.remove(token)
        db.session.add(blacklist)
        flag_modified(self, "auth_tokens")
        db.session.commit()
        

    # Other fields
    orgs = db.Column(db.JSON, nullable=False, default={
        'main_org': {},
        'orgs': []
    })

    disabled = db.Column(db.Boolean, default=False)

    previous_handles = db.Column(db.JSON, nullable=False, default={
        'handles': [],
        'citizen_number': []
    })

    security_level = db.Column(db.Integer, nullable=False, default=1)
    
    api_key = db.Column(db.String(100), unique=True, default=lambda: str(secrets.token_urlsafe(64)))
    api_key_enabled = db.Column(db.Boolean, default=False)
    
    logs = db.Column(db.JSON, nullable=False, default=[])
    
    roles = db.relationship('Role', secondary='user_role', back_populates='users', lazy='select', overlaps="user")
    
    def add_role(self, role):
        from corp_system.bot.controller import Bot_controller
        
        if not self.CORP_confirmed:
            raise ValueError("User is not confirmed in the corporation, so roles cannot be added yet")
        
        if role not in self.roles:
            self.roles.append(role)
            db.session.commit()
            
            try:
                Bot_controller.add_role(self, role)
            except:
                print("Issue with bot controller")
            
            self.update()

    def remove_role(self, role):
        from corp_system.bot.controller import Bot_controller
        
        if role in self.roles:
            self.roles.remove(role)
            db.session.commit()
            
            try:
                Bot_controller.remove_role(self, role)
            except:
                print("Issue with bot controller")
                
            self.update()
            
    
    # Structure methods
    @property
    def divisions(self):
        from corp_system.models import Division
        return [division for division in Division.query.all() if division.is_member(self)]

    @property
    def departments(self):
        from corp_system.models import Department
        return [department for department in Department.query.all() if department.is_member(self)]
    
    
    def is_admin(self):
        return self.security_level == 10
    
    def is_manager(self, division=None, department=None):
        if self.is_admin():
            return True
        elif division:
            if division.leader_role in self.roles:
                return True
        elif department:
            if department.head_role in self.roles:
                return True
        else:
            for current_division in self.divisions:
                if current_division.leader_role in self.roles:
                    return True
            for current_department in self.departments:
                if current_department.head_role in self.roles:
                    return True
        return False

    def update(self, force=False):
        
        if not self.RSI_confirmed or self.CORP_confirmed or force:
            try:
                RSI_info = RSI_account(RSI_handle=self.RSI_handle)
                
                if RSI_info.RSI_handle:
                    self.RSI_handle = RSI_info.RSI_handle
                
                if RSI_info.corp_member():
                    self.CORP_confirmed = True
                    
                    self.orgs = RSI_info.as_json()['Orgs']
                
                if not self.RSI_confirmed and RSI_info.confirm_token(self.RSI_verification_token):
                    self.RSI_confirmed = True
            except:
                print("Issue with RSI website")
        
        if self.CORP_confirmed:
            if not self.inf_account:
                from corp_system.models import Inf_Account
                account = Inf_Account(user=self)
                db.session.add(account)
                db.session.commit()
                account.update()
            else:
                self.inf_account.update()
        
        
        from corp_system.models import Role
        if self.CORP_confirmed:
            self.add_role(Role.query.filter_by(title='Corporateer').first())
        
        try:
            from corp_system.bot.controller import Bot_controller
            Bot_controller.update_nickname(self)
            Bot_controller.sync_role(self)
            
            from corp_system.controllers.structure_manager import StructureManager
            StructureManager.equalize_roles(self)
        except:
            print("Issue with bot controller")
        
        for token in self.auth_tokens:
            expiration = datetime.fromtimestamp(token['exp'])
            if expiration < datetime.now():
                self.auth_tokens.remove(token)
        
        from corp_system.controllers.structure_manager import StructureManager
        StructureManager.equalize_roles(self)
        
        db.session.commit()


    def log(self, log_type, log_data):
        # Create a new log
        new_log = {
            'type': log_type,
            'data': log_data,
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        # Insert the new log at the beginning of the logs list
        self.logs = [new_log] + self.logs

        # Make sure the logs list doesn't get larger than 10000 elements
        self.logs = self.logs[:10000]

        # Update the user in the database
        db.session.commit()
        
    def disable(self):
        """
        Disable the user and all related UserRole.
        """
        
        self.disabled = True
            
        db.session.commit()
        
    def delete(self):
        
        
        self.disable()
        
        from corp_system.models import UserRole
        # Delete all related UserRole
        links = UserRole.query.filter_by(user_id=self.id)
        for link in links:
            link.delete()
        # Delete the user
        db.session.delete(self)
        db.session.commit()
    

    def as_dict(self):
        """
        Convert user data to dictionary.
        """
        return {
            'id': self.id,
            'RSI_handle': self.RSI_handle,
            'RSI_moniker': self.RSI_moniker,
            'RSI_number': self.RSI_number,
            'image_link': self.image_link,
            'RSI_confirmed': self.RSI_confirmed,
            'CORP_confirmed': self.CORP_confirmed,
            'RSI_verification_token': self.RSI_verification_token,
            'Enabled_2FA': self.Enabled_2FA,
            'orgs': self.orgs,
            'disabled': self.disabled,
            'previous_handles': self.previous_handles,
            'login_attempt': self.login_attempt,
            'security_level': self.security_level,
        }

    def __repr__(self):
        """
        Represent user as a string.
        """
        return f"User('{self.RSI_handle}', '{self.RSI_moniker}')"