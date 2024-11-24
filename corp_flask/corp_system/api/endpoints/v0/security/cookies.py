from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, decode_token
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager

from corp_system.models import User

import datetime
import jwt


@api.route('/cookie_expiration', methods=['GET'])
def get_cookie_expiration():
    """Get the cookie expiration
    
    This endpoint return the cookies expiration
    ---
    
    operationId: get_cookie_expiration
    tags:
        - Security
    responses:
        200:
            description: Cookie were deleted
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            corp_access_pass_expiration:
                                type: string
                                example: expired
                            corp_refresh_pass_expiration:
                                type: string
                                example: 3485783465783453653
                            
        400:
            description: error happened

    """
    
    corp_access_pass = request.cookies.get('corp_access_pass')
    corp_refresh_pass = request.cookies.get('corp_refresh_pass')
    
    # Decode the JWT tokens
    corp_access_pass_decoded = jwt.decode(corp_access_pass, options={"verify_signature": False})
    corp_refresh_pass_decoded = jwt.decode(corp_refresh_pass, options={"verify_signature": False})
    
    # Extract the expiration times
    corp_access_pass_expiration = datetime.datetime.fromtimestamp(corp_access_pass_decoded['exp']).strftime('%s')
    corp_refresh_pass_expiration = datetime.datetime.fromtimestamp(corp_refresh_pass_decoded['exp']).strftime('%s')
    
    
    return jsonify({
        'current': datetime.datetime.now().strftime('%s'),
        'corp_access_pass_expiration': corp_access_pass_expiration if corp_access_pass_expiration > datetime.datetime.now().strftime('%s') else 'expired',
        'corp_refresh_pass_expiration': corp_refresh_pass_expiration if corp_refresh_pass_expiration > datetime.datetime.now().strftime('%s') else 'expired'
    }), 200


@api.route('/remove_cookie', methods=['GET'])
def remove_cookie():
    """Delete the cookie
    
    This endpoint delete all the 4 cookies set by the server
    ---
    
    operationId: remove_cookie
    tags:
        - Security
    responses:
        200:
            description: Cookie were deleted
        400:
            description: error happened

    """
    
    response = jsonify({"msg": "Cookie were deleted"})
    unset_jwt_cookies(response)
    
    return response, 200