from flask import Flask, request, jsonify, make_response, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import jwt
import datetime
from functools import wraps
from flask_login import current_user


def confirmed_RSI_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user is None or not current_user.RSI_confirmed:
            return redirect(url_for('login', next=request.url))
        
        return f(*args, **kwargs)
    return decorated_function

def CORP_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user is None or not current_user.corp_confirmed:
            return redirect(url_for('login', next=request.url))
        
        return f(*args, **kwargs)
    return decorated_function

def manager_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user is None or not current_user.is_manager():
            return redirect(url_for('login', next=request.url))
        
        return f(*args, **kwargs)
    return decorated_function


def admin_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user is None or not current_user.is_manager("admin"):
            return redirect(url_for('login', next=request.url))
        
        return f(*args, **kwargs)
    return decorated_function

def not_logged_in_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user:
            return redirect(url_for('main.home'))
        
        return f(*args, **kwargs)
    return decorated_function