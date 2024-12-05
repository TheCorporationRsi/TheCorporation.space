from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.structure_manager import StructureManager



@api.route('/structure/departments', methods=['GET'])
def departments():
    """List of all departments
    
    Returns a list of all the departments in the system
    ---
    
    operationId: get_departments
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
                                motto:
                                    type: string
                                    example: We love building stuff
                                member_count:
                                    type: integer
                                    example: 50
                                heads:
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
                                divisions:
                                    type: array
                                    items:
                                        type: string
                                        example: [
                                            Development,
                                            Extration
                                        ]
    """
    departments = Department.query.all()
    departments_list = []
    
    for department in departments:
        
        departments_list.append({
            "title": department.title,
            "color": department.color,
            "motto": department.motto,
            "member_count": len(department.members),
            "divisions": [division.title for division in department.divisions if division.hidden == False],
            "heads": [head.RSI_handle for head in department.head_role.users],
            "proxys": [proxy.RSI_handle for proxy in department.proxy_role.users],
        })
    
    return jsonify(departments_list), 200



@api.route('/structure/departments', methods=['POST'])
@admin_only
def create_department():
    """Department creation endpoint
    
    This endpoint allow the creation of a new department
    ---
    
    operationId: create_department
    security:
        - corp_access_pass: []
    tags:
        - Admin
    requestBody:
        description: Department information
        content:
            application/json:
                schema:
                    type: object
                    required: [title]
                    properties:
                        title:
                            type: string
                            example: Ressources

    responses:
        200:
            description: Login was successfull
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Department created
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    title = request.json.get("title")
    #print(username, password)
    
    try:
        StructureManager.create_department(title=title)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({'msg': "Department created"}), 200