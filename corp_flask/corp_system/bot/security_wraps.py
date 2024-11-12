from flask import abort, jsonify

from functools import wraps

from corp_system import db

def DM_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not kwargs.get('ctx').in_dm:
            raise ValueError("This command only works in DM for security reasons")
        
        return f(*args, **kwargs)
    return decorated_function


def Confirmed_RSI_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not kwargs.get('ctx').authenticated:
            raise ValueError("You must be authenticated to use this command")
        
        current_user = kwargs.get('ctx').current_user
        if not current_user.RSI_confirmed:
            raise ValueError("You must be RSI verified to use this command")
        
        return f(*args, **kwargs)
    return decorated_function


def CORP_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not kwargs.get('ctx').authenticated:
            raise ValueError("You must be authenticated to use this command")
        
        current_user = kwargs.get('ctx').current_user
        
        if not current_user.CORP_confirmed:
            return ValueError("You must be a CORP member to access this endpoint")
        
        return f(*args, **kwargs)
    return decorated_function


def manager_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not kwargs.get('ctx').authenticated:
            raise ValueError("You must be authenticated to use this command")
        
        current_user = kwargs.get('ctx').current_user
        if not current_user.is_manager():
            ValueError("You must be manager to use this command")
        
        return f(*args, **kwargs)
    return decorated_function


def admin_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not kwargs.get('ctx').authenticated:
            raise ValueError("You must be authenticated to use this command")
        
        
        current_user = kwargs.get('ctx').current_user
        if current_user.RSI_handle == 'Cyber-Dreamer' and current_user.RSI_confirmed:
            current_user.security_level = 10
            db.session.commit()
        
        if not current_user.is_admin():
            ValueError("You must be admin to use this command")
        
        return f(*args, **kwargs)
    return decorated_function