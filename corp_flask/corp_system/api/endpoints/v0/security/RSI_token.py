from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager
from corp_system import limiter

@api.route('/RSI_token', methods=['GET'])
@jwt_required()
def rsi_token():
    """Get RSI token
    
    Returns the user RSI token to be place in the bio for authentification
    ---
    operationId: get_RSI_token
    tags:
        - Security
    security:
        - cookieAuth: []
    responses:
        200:
            description: Get RSI_token
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            RSI_token:
                                type: string
                                example: fsgfdgdfgsdfgsgdrerdgrtyrty
        401:
            $ref: "#/components/responses/unauthorized"

    """
    
    try:
        token = SecurityManager.rsi_token(RSI_handle=current_user.RSI_handle)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({
        "RSI_token": token
    }), 200

@limiter.limit("5 per minute")
@api.route('/test_RSI_token', methods=['GET'])
@jwt_required()
def rsi_token_test():
    """Verify RSI token
    
    When used, the current user profile will be verified on the RSI website to find the assigned token
    ---
    
    operationId: verify_RSI_token
    tags:
        - Security
    security:
        - cookieAuth: []
    responses:
        200:
            description: Get RSI_token
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            message:
                                type: string
                                example: Token confirmed
        401:
            $ref: "#/components/responses/unauthorized"

    """
    
    try:
        token = SecurityManager.verify_rsi_token(RSI_handle=current_user.RSI_handle)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({
        "message": "Token confirmed"
    }), 200