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
        ctx = kwargs['ctx']
        #ctx.send("triggered")
        if ctx.user == -1 or ctx.user == None:
            ctx.send("You are not linked to CORP website")
            return
            
        elif not ctx.user.RSI_confirmed:
            ctx.send("You need to verify you RSI account first to use this function")
            return 
        
        return f(*args, **kwargs)
    return decorated_function

def CORP_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        #ctx.send("triggered")
        if ctx.user == -1 or ctx.user == None:
            ctx.send("You are not linked to CORP website")
            return
        elif not ctx.user.corp_confirmed:
            ctx.send("You need to be a CORP member to use this command")
            return 
        
        return f(*args, **kwargs)
    return decorated_function


def manager_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        #ctx.send("triggered")
        if ctx.user == -1 or ctx.user == None:
            ctx.send("You are not linked to CORP website")
            return 
        elif not ctx.user.is_manager():
            ctx.send("You need to be a CORP member to use this command")
            return 
        
        return f(*args, **kwargs)
    return decorated_function


def admin_only(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        ctx = kwargs['ctx']
        #ctx.send("triggered")
        if ctx.user == -1 or ctx.user == None:
            ctx.send("You are not linked to CORP website")
            return 
        elif not ctx.user.is_manager("admin"):
            ctx.send("You need to be a CORP member to use this command")
            return 
        
        return f(*args, **kwargs)
    return decorated_function

