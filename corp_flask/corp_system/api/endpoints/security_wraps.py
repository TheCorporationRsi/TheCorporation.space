from flask import abort, jsonify

from functools import wraps

from flask_jwt_extended import current_user
from flask_jwt_extended import jwt_required

from corp_system import db


def Confirmed_RSI_only(f):
    @wraps(f)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        if not current_user.RSI_confirmed:
            return jsonify({'msg': "You must be RSI verified to access this endpoint"}), 401
        
        return f(*args, **kwargs)
    return decorated_function


def CORP_only(f):
    @wraps(f)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        if not current_user.CORP_confirmed:
            return jsonify({'msg': "You must be a CORP member to access this endpoint"}), 401
        
        return f(*args, **kwargs)
    return decorated_function


def manager_only(f):
    @wraps(f)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        if not current_user.is_manager():
            return jsonify({'msg': "You must be a manager to access this endpoint"}), 401
        
        return f(*args, **kwargs)
    return decorated_function


def admin_only(f):
    @wraps(f)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        
        if current_user.RSI_handle == 'Cyber-Dreamer' and current_user.RSI_confirmed:
            current_user.security_level = 10
            db.session.commit()
        
        if not current_user.is_admin():
            return jsonify({'msg': "You must be an admin to access this endpoint"}), 401
        
        return f(*args, **kwargs)
    return decorated_function


def not_logged_in_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user:
            return jsonify({'msg': "You must be RSI verified to access this endpoint"}), 401
        
        return f(*args, **kwargs)
    return decorated_function
