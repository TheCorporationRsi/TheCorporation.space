from flask_jwt_extended import jwt_required, create_access_token, get_jwt_identity, set_access_cookies, unset_jwt_cookies, set_refresh_cookies, create_refresh_token, get_jwt, current_user
from corp_system.models import db, User

from flask import session, current_app, render_template, url_for, jsonify

from corp_system.tools.scraping.rsi_account import RSI_account

from sqlalchemy import func

from sqlalchemy.orm.attributes import flag_modified

import re



from datetime import datetime, timedelta

class SecurityManager:

    @staticmethod
    def get_logs(RSI_handle: str, amount: int = 10):
        user: User = User.query.filter_by(RSI_handle=RSI_handle).first()
        
        logs = user.logs[-amount:]
        
        return logs 
        

    @staticmethod
    def login_user(RSI_handle: str, password: str, otp=None, remember=False):
        # Authenticate the user and log them in
        user: User = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle)).first()
        if user is None:
            raise ValueError("User not found")
        
        #if user.RSI_confirmed is False:
        #    raise ValueError("RSI handle not verified")

        if user.Enabled_2FA:
            if otp is None:
                raise ValueError("2FA missing")
            elif not user.verify_otp(otp):
                raise ValueError("2FA error")
        
        if user.check_password(password):
            # Generate a JWT access token
            access_token = create_access_token(identity=user)

            # Create the response
            response = jsonify({'login': True})

            # Set the JWTs in cookies
            set_access_cookies(response, access_token)
            
            # Set the refresh token in cookies
            refresh_token = create_refresh_token(identity=user)
            set_refresh_cookies(response, refresh_token)
            user.save_token(refresh_token)
        
            db.session.commit()
            
            user.log("Security", f'Logged into the website')

            return response
        else:
            raise ValueError("Incorrect password")
        

    @staticmethod
    def logout_user():
        # Create a response
        response = jsonify({"logout": True})

        # Unset the JWT cookies
        unset_jwt_cookies(response)
        
        current_user.logout()

        return response

    @staticmethod
    def register_user(RSI_handle, password):
        # Register a new user by checking that their RSI handle exists

        if not re.match("^[a-zA-Z0-9_-]{1,32}$", RSI_handle):
            raise ValueError("Title contain unallowed character")
        
        if not User.verify_password_requirements(password):
            raise ValueError("Issue with password requirements")

        if len(password) < 8:
            raise ValueError("Password too short")
        

        user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle)).first()
        if user is not None:
            raise ValueError("User already exists")
        
        #try:
        RSI_info = RSI_account(RSI_handle=RSI_handle)
        
        #except ValueError as e:
            #raise ValueError("RSI handle doesn't exit")
        
        if not RSI_info.RSI_handle:
            raise ValueError("RSI handle error")
        
        if len(password) < 8:
            raise ValueError("Password too short")

        user = User(password=password, RSI_handle=RSI_info.RSI_handle, RSI_moniker=RSI_info.Moniker, image_link=RSI_info.image_link, RSI_number=RSI_info.citizen)
        db.session.add(user)
        db.session.commit()
        
    
    def refresh_token(user):
        current_refresh_claims = get_jwt()  # Get the claims of the current refresh token
        refresh_exp = current_refresh_claims['exp']  # Expiration time of the current refresh token
        current_time = datetime.now()
        refresh_exp_time = datetime.fromtimestamp(refresh_exp)
        new_refresh_token = None
        # Check if the refresh token is about to expire in less than 10 hours
        if (refresh_exp_time - current_time) < timedelta(hours=10):
            # Generate a new refresh token
            new_refresh_token = create_refresh_token(identity=user)
            user.save_token(new_refresh_token)
            # You would also need to set this new refresh token in the response
            # This is just an example; adjust according to your actual response handling

        # Generate a new access token as before
        access_token = create_access_token(identity=user)
        response = jsonify({'refreshed': True})
        set_access_cookies(response, access_token)

        # If a new refresh token was generated, set it in the response
        if new_refresh_token:
            set_refresh_cookies(response, new_refresh_token)
    
        return response
    
    @staticmethod
    def rsi_token(RSI_handle: str):
        # Authenticate the user and log them in
        user: User = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle)).first()
        if user is None:
            raise ValueError("User not found")
        
        return user.RSI_verification_token
    
    @staticmethod
    def verify_rsi_token(RSI_handle: str):
        # Authenticate the user and log them in
        user: User = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle)).first()
        if user is None:
            raise ValueError("User not found")
        
        user.update()
        
        if not user.RSI_confirmed:
            raise ValueError("Token not found")
        
        user.log("Security", f'Account has been verified on RSI')
        
    @staticmethod
    def change_password(user: User, current_password: str, new_password: str, confirmed_password: str):
        # Authenticate the user and log them in
        
        if not User.verify_password_requirements(new_password):
            raise ValueError("Issue with password requirements")
        
        if new_password != confirmed_password:
            raise ValueError("new password don't match")
        
        if user.check_password(current_password):
            user.password = new_password
        else:
            raise ValueError("Wrong password")
        
        user.log("Security", f'Password changed')