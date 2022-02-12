from ... import api
from flask import jsonify
from ....models import User
import jwt
from ...security_wraps import admin_only, manager_only

from flask_login import current_user, login_required
'''
@login_required
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
'''