from .... import api
from flask import jsonify

import jwt
from ....security_wraps import admin_only, manager_only, CORP_only
from project.models import User

from flask_login import current_user, login_required

@CORP_only
@api.route('/update_user/<string:id>', methods=["GET"])
def update_user(id):
    user = User.query.filter_by(id = id).first()
    user.update_info()
    
    return jsonify('lol')