from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api
from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager

from corp_system import limiter

@limiter.limit("5 per minute")
@api.route('/login', methods=['POST'])
def login():
    """Authetification endpoint
    
    This endpoint allow login with username:password
    ---
    
    operationId: login
    tags:
        - Security
    security: []
    requestBody:
        description: login information
        content:
            application/json:
                schema:
                    type: object
                    required: [username, password]
                    properties:
                        username:
                            type: string
                            example: Cyber-Dreamer
                        password:
                            type: string
                            example: 123CorpIsTheBest!
                        otp:
                            type: integer
                            example: 12342
    responses:
        200:
            description: Login was successfull
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: logged_in
                            corp_access_pass:
                                type: string
                                example: eyJ0eXAiOi
                            corp_refresh_pass:
                                type: string
                                example: eyJ0eXAiOi
                                
        400:
            $ref: "#/components/responses/invalid"

    """
    username = request.json.get("username")
    password = request.json.get("password")
    otp = request.json.get("otp")
    #print(username, password, otp)
    
    try:
        response = SecurityManager.login_user(RSI_handle=username, password=password, otp=otp)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return response


@api.route('/protected', methods=['GET', 'POST'])
@Confirmed_RSI_only
def protected():
    return "Hello, World!"