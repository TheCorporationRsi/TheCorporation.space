from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager

from corp_system.models import User




@api.route('/status', methods=['GET'])
@jwt_required(optional=True)
def get_status():
    """Get current authentification status
    
    This endpoint provide information on what you currently have access
    ---
    
    operationId: get_status
    tags:
        - Security
    responses:
        200:
            description: Current authentification status
            content:
                application/json:
                    schema:
                        required: [authentificated, RSI_verified, CORP_member, is_manager, is_admin]
                        properties:
                            authentificated:
                                type: boolean
                            RSI_verified:
                                type: boolean
                            CORP_member:
                                type: boolean
                            is_manager:
                                type: boolean
                            is_admin:
                                type: boolean
                        type: object
        400:
            description: error happened

    """
    
    current_user: User = current_user if get_jwt_identity() else None
    
    return jsonify({
        "authentificated": True if current_user is not None else False,
        "RSI_verified": current_user.RSI_confirmed if current_user is not None else False,
        "CORP_member": current_user.CORP_confirmed if current_user is not None else False,
        "is_manager": current_user.is_manager() if current_user is not None else False,
        "is_admin": current_user.is_admin() if current_user is not None else False
    }), 200