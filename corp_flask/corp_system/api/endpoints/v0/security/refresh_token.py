from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only
from flask_jwt_extended import jwt_required, current_user 
from .. import api_v0 as api
from corp_system.controllers.security_manager import SecurityManager
from corp_system import limiter

@limiter.limit("5 per minute")
@api.route('/refresh_token', methods=['POST'])
@jwt_required(refresh=True)
def refresh_token():
    """Path to refresh cookie that are soon to expire
    
    This is using docstrings for specifications.
    ---
    
    operationId: refresh_token
    tags:
        - Security
    security:
      - csrf_refresh: []
    responses:
      200:
        description: Transfer was successfull
      401:
        description: You do not have access to this endpoint

    """
    response = SecurityManager.refresh_token(current_user)
    return response