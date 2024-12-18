from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/structure/set_weights', methods=['POST'])
@CORP_only
def set_weights():
    """Division weight assignment
    
    This endpoint goal is to set the weight of the member's divisions 
    ---
    
    operationId: set_weights
    tags:
        - Structure
    security:
        - corp_access_pass: []
    requestBody:
        description: Division information
        content:
            application/json:
                schema:
                    type: array
                    items:
                        type: object
                        properties:
                            title:
                                type: string
                                example: Development
                            amount:
                                type: integer
                                example: 25
    responses:
        200:
            description: Weight set successful
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Weights updated!
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    division_list = request.json
    
    total = 0
    for division in division_list:
        title = division.get("title")
        amount = division.get("amount")
        total += amount
        division = Division.query.filter_by(title=title).first()
        if division is None:
            return jsonify({'msg': "Wrong division title"}), 400
    
        if division not in current_user.divisions:
            return jsonify({'msg': "Not member of all divisions"}), 400
    
        if not isinstance(amount, int) or amount > 100 or amount < 1:
            return jsonify({'msg': "Amounts must be integer between 1 and 100"}), 400
    
    if total != 100:
        return jsonify({'msg': "Total weight must be 100"}), 400
    
    for division in division_list:
        title = division.get("title")
        amount = division.get("amount")
        division = Division.query.filter_by(title=title).first()
        try:
            division.set_weight(user=current_user, weight=amount)
        except ValueError as e:
            return jsonify({'msg': str(e)}), 400
    
    current_user.update()
    
    
    return jsonify({'msg': "Weights updated!"}), 200
