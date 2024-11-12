from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/influence_system/ranks', methods=['GET'])
@jwt_required(optional=True)
def ranks():
    """List of all influence system ranks
    
    This is using docstrings for specifications.
    ---
    tags:
        - Influence System
    security: []
    responses:
      200:
        description: Transfer was successfull
        content:
             application/json:
                schema:
                    type: object
                    properties:
                        title:
                            type: string
                            example: Corporateer
                        required_lifetime_influence:
                            type: integer
                            example: 0
                        weekly_amount:
                            type: integer
                            example: 50

    """
    
    ranks = Inf_Rank.query.all()
    rank_list = []
    
    for rank in ranks:
        rank_list.append({
            "title": rank.title,
            "required_lifetime_influence": rank.required_lifetime_influence,
            "weekly_amount": rank.weekly_amount
        })
    
    return jsonify(rank_list), 200



