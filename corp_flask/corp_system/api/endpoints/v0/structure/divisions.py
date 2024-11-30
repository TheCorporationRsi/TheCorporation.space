from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department


from corp_system.controllers.structure_manager import StructureManager

@api.route('/structure/divisions', methods=['GET'])
def divisions():
    """List of all divisions
    
    Returns a list of all the divisions in the system
    ---
    
    operationId: get_divisions
    tags:
        - Structure
    security: []
    responses:
        200:
            description: List acquired
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
                                color:
                                    type: string
                                    example: #0083ff
                                department_title:
                                    type: string
                                    example: Ressources
                                motto:
                                    type: string
                                    example: We love building stuff
                                member_count:
                                    type: integer
                                    example: 50
                                leaders:
                                    type: array
                                    items:
                                        type: string
                                        example: [
                                        Cyber-Dreamer
                                        ]
                                proxys:
                                    type: array
                                    items:
                                        type: string
                                        example: [
                                            Stevote,
                                            Vizi
                                        ]

    """
    
    divisions = Division.query.filter_by(hidden=False).all()
    divisions_list = []
    
    for division in divisions:
        
        divisions_list.append({
            "title": division.title,
            "color": division.color,
            "department_title": division.department.title,
            "motto": division.motto,
            "leaders": [leader.RSI_handle for leader in division.leader_role.users],
            "proxys": [proxy.RSI_handle for proxy in division.proxy_role.users],
            "member_count": len(division.members)
        })
    
    return jsonify(divisions_list), 200


@api.route('/structure/divisions', methods=['POST'])
@admin_only
def create_division():
    """Division creation endpoint
    
    This is the admin endpoint to create new divisions
    ---
    
    operationId: create_division
    tags:
        - Admin
    security:
        - corp_access_pass: []
    requestBody:
        description: Division information
        content:
            application/json:
                schema:
                    type: object
                    required: [title]
                    properties:
                        title:
                            type: string
                            example: Development

    responses:
        200:
            description: Login was successful
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Division created
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    title = request.json.get("title")
    derpartment_title = request.json.get("derpartment_title")
    #print(username, password)
    
    try:
        StructureManager.create_division(title=title, derpartment_title=derpartment_title)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({'msg': "Division created"}), 200