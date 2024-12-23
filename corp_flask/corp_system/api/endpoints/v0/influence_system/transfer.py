from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from sqlalchemy import func

from flask import jsonify, request

from corp_system.models import Inf_Rank, User

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/influence_system/transfer', methods=['POST'])
@CORP_only
def transfer():
    """Endpoint to send tribute to another corporateer
    
    This is the main endpoint to effectuate tribute transfer to another corporateer
    ---
    
    operationId: send_tribute
    tags:
        - Influence System
    security: 
        - corp_access_pass: []
    requestBody:
        description: transfer information
        content:
            application/json:
                schema:
                    type: object
                    required: [receiver_handle, amount]
                    properties:
                        receiver_handle:
                            type: string
                            example: Cyber-Dreamer
                        amount:
                            type: integer
                            example: 10
                            description: Amount of tribute that you wish to send
                        message:
                            type: string
                            example: Thanks for building this
    responses:
        200:
            description: Transfer was successful
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
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    receiver_handle = request.json.get("receiver_handle")
    amount = request.json.get("amount")
    message = request.json.get("message")

    receiver = User.query.filter(func.lower(User.RSI_handle) == func.lower(receiver_handle)).first()
    if receiver is None:
        return jsonify({'msg': "Member not found"}), 400
    
    try:
        InfluenceSystemManager.send_tribute(sender=current_user, receiver=receiver, amount=amount, message=message, method="website")
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({'msg': "Transfer successfull!"}), 200



