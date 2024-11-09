from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.structure_manager import StructureManager



@api.route('/structure/departments', methods=['GET'])
def departments():
    """List of all departments
    
    This is using docstrings for specifications.
    ---
    tags:
        - Structure
    security: []
    responses:
      200:
        description: List aquired
        content:
             application/json:
                schema:
                    type: object
                    properties:
                        title:
                            type: string
                            example: Ressources
                        color:
                            type: string
                            example: #0083ff
                        motto:
                            type: string
                            example: We love building stuff
                        logo:
                            type: string
                            example: logo.svg
                        member_count:
                            type: integer
                            example: 50
                        division:
                            type: object
                            example: [
                                Development,
                                Extraction,
                                Transport
                            ]
                        heads:
                            type: object
                            example: [
                                Cyber-Dreamer
                            ]
                        proxys:
                            type: object
                            example: [
                                Stevote,
                                Vizi
                            ]

    """
    departments = Department.query.all()
    departments_list = []
    
    for department in departments:
        
        departments_list.append({
            "title": department.title,
            "color": department.color,
            "motto": department.motto,
            "logo": department.logo,
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
    
    This is using docstrings for specifications.
    ---
    tags:
        - Admin
    requestBody:
        description: Department information
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        title:
                            type: string
                            example: Ressources

    responses:
      200:
        description: Login was successfull
        schema:
            type: object
            properties:
                msg:
                    type: string
                    example: Department created
      400:
        description: An error happen with the info that you submitted
        schema:
            type: object
            properties:
                msg:
                    type: string
                    example: You must be admin to access this endpoint

    """
    title = request.json.get("title")
    #print(username, password)
    
    try:
        StructureManager.create_department(title=title)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({'msg': "Department created"}), 200