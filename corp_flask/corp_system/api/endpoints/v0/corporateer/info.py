from ....security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.corporateer_manager import CorporateerManager

@api.route('/corporateers', methods=['GET'])
@CORP_only
def corporateers():
    """List of all corporateer
    
    This is using docstrings for specifications.
    ---
    tags:
        - Information
    responses:
      200:
        description: Transfer was successfull
        content:
             application/json:
                schema:
                    type: array
                    example:
                        [
                        {
                            "RSI_handle": "Cyber-Dreamer",
                            "RSI_moniker": "CyberDreamer"
                        }
                        ]
      401:
        description: You do not have access to this endpoint

    """
    
    try:
        corp_list = CorporateerManager.corporateers_list()
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify(corp_list), 200

@api.route('/corporateers/<RSI_handle>', methods=['GET'])
@CORP_only
def corporateer(RSI_handle):
    
    try:
        corp_list = CorporateerManager.get_member(RSI_handle)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify(corp_list), 200