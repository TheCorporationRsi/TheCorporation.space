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
    
    In order to gain a new token once expired, the frontend must submit the refresh token to get a new one.
    ---
    
    operationId: refresh_token
    tags:
        - Security
    security:
      - corp_refresh_pass: []
    responses:
      200:
        description: Token successfully refreshed
        content:
                application/json:
                    schema:
                        type: object
                        properties:
                            refreshed:
                                type: boolean
                                example: true
                            corp_access_pass:
                                type: string
                                example: eyJ0eXAiOi
                            corp_refresh_pass:
                                type: string
                                example: eyJ0eXAiOi
      400:
        $ref: "#/components/responses/invalid"
      401:
        $ref: "#/components/responses/unauthorized"

    """
    response = SecurityManager.refresh_token(current_user)
    return response