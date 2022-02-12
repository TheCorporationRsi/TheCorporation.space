from ... import api
from flask import jsonify

import jwt
from ...security_wraps import admin_only, manager_only, CORP_only
from project.models import User

from flask_login import current_user, login_required

@CORP_only
@api.route('/users', methods=["GET"])
def users():
    users = User.query.all()
    if current_user.is_manager("admin"):
        list_users = [r.as_dict() for r in users]
    else:
        list_users = [r.as_dict_public() for r in users]
    
    return jsonify(list_users)

@login_required
@api.route('/users/my_profile', methods=["GET"])
def my_profile():
    if current_user and not current_user.is_anonymous:
        user = current_user.as_dict_private()
    else:
        user = None
    return jsonify(user)


@admin_only
@api.route('/users/<string:attribute>/<string:data>', methods=["GET"])
def look_for_user(attribute, data):
    if attribute == "id":
        user = User.query.filter_by(id = data).first().as_dict()
    elif attribute == "RSI_handle":
        user = User.query.filter_by(RSI_handle = data).first().as_dict()
    elif attribute == "discord_id":
        user = User.query.filter_by(discord_id = data).first().as_dict()
    elif attribute == "email":
        user = User.query.filter_by(email = data).first().as_dict()
    else:
        user = None
    
    return jsonify(user)









