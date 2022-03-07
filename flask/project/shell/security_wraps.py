from flask import Flask, request, jsonify, make_response, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import jwt
import datetime
from functools import wraps
from flask_login import current_user

from project.models import User


def confirmed_RSI_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        user = ctx.user
        if not user.RSI_confirmed:
            return ctx.send("You need to verify you RSI account first to use this function")
        
        return f(*args, **kwargs)
    return decorated_function

def CORP_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        user = ctx.user
        if not user.corp_confirmed:
            return ctx.send("You need to be a CORP member to use this command")
        
        return f(*args, **kwargs)
    return decorated_function


def manager_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        user = ctx.user
        if not user.is_manager():
            return ctx.send("You need to be a CORP member to use this command")
        
        return f(*args, **kwargs)
    return decorated_function


def admin_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        user = ctx.user
        if not user.is_manager("admin"):
            return ctx.send("You need to be a CORP member to use this command")
        
        return f(*args, **kwargs)
    return decorated_function

