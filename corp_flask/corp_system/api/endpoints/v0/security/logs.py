from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.security_manager import SecurityManager


@api.route('/logs', methods=['GET'])
@jwt_required()
def get_logs():
    """Get your logs
    
    This returns a list of all the logs that have been assigned to your account
    ---
    
    operationId: get_logs
    tags:
        - Security
    security:
        - corp_access_pass: []
    responses:
        200:
            description: List of your last 100 logs
        401:
            $ref: "#/components/responses/unauthorized"

    """
    
    try:
        logs = SecurityManager.get_logs(RSI_handle=current_user.RSI_handle, amount=100)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({
        "logs": logs
    }), 200
    