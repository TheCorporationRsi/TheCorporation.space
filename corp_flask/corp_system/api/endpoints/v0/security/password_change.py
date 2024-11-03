from ....security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager


@api.route('/change_password', methods=['POST'])
@jwt_required()
def pasword_change():
    """Change password
    This is using docstrings for specifications.
    ---
    tags:
        - Security
    requestBody:
        description: registration information
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        current_password:
                            type: string
                            example: 123CorpIsTheBest!
                        new_password:
                            type: string
                            example: ILoveWeyland69!
                        confirmed_password:
                            type: string
                            example: ILoveWeyland69!
    responses:
      200:
        description: Password changed
      401:
        description: You do not have access to this endpoint

    """
    
    current_password = request.json.get("current_password")
    new_password = request.json.get("new_password")
    confirmed_password = request.json.get("confirmed_password")
    
    try:
        SecurityManager.change_password(user=current_user, current_password=current_password, new_password=new_password, confirmed_password=confirmed_password)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({"msg": "Password changed"}), 200