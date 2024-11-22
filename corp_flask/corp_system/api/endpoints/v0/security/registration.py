from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager

from corp_system import limiter

@limiter.limit("5 per minute")
@api.route('/register', methods=['POST'])
def register():
    """Registration endpoint
    
    This registers the current RSI handle in the system
    ---
    
    operationId: register
    tags:
        - Security
    security: []
    requestBody:
        description: registration information
        content:
            application/json:
                schema:
                    type: object
                    required: [username, password, confirmed_password]
                    properties:
                        username:
                            type: string
                            example: Cyber-Dreamer
                        password:
                            type: string
                            example: 123CorpIsTheBest!
                        confirmed_password:
                            type: string
                            example: 123CorpIsTheBest!
    responses:
        200:
            description: Login was successful
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: registration successfull!
        400:
            $ref: "#/components/responses/invalid"

    """
    username = request.json.get("username")
    password = request.json.get("password")
    confirmed_password = request.json.get("confirmed_password")
    #print(username, password)
    
    if password != confirmed_password:
        return jsonify({'msg': "Password don't match"}), 400
    
    try:
        SecurityManager.register_user(RSI_handle=username, password=password)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({'msg': "User created"}), 200