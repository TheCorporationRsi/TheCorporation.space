from ....security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager


@api.route('/RSI_token', methods=['GET'])
@jwt_required()
def rsi_token():
    """Get RSI token
    This is using docstrings for specifications.
    ---
    tags:
        - Security
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
        description: You do not have access to this endpoint

    """
    
    try:
        token = SecurityManager.rsi_token(RSI_handle=current_user.RSI_handle)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({
        "RSI_token": token
    }), 200
    

@api.route('/test_RSI_token', methods=['GET'])
@jwt_required()
def rsi_token_test():
    """verify RSI token
    This is using docstrings for specifications.
    ---
    tags:
        - Security
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
        description: You do not have access to this endpoint

    """
    
    try:
        token = SecurityManager.verify_rsi_token(RSI_handle=current_user.RSI_handle)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({
        "message": "Token confirmed"
    }), 200