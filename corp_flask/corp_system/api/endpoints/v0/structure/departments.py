from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department
from corp_system import db

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
                                logo:
                                    type: string
                                    example: disabled_by_default
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
                            example: Resources
    responses:
        200:
            description: Department created
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

@api.route('/structure/departments', methods=['PATCH'])
@admin_only
def update_department():
    """Department update endpoint
    
    This endpoint allow the update of a department
    ---
    
    operationId: update_department
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
                    required: [department_title]
                    properties:
                        department_title:
                            type: string
                            example: Resources
                        new_title:
                            type: string
                            example: Resources
                        color:
                            type: string
                            example: #0083ff
                        motto:
                            type: string
                            example: We love building stuff
                        logo:
                            type: string
                            example: disabled_by_default
    responses:
        200:
            description: Department modified
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Department modified
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    data = request.get_json()
    
    department_title = data.get('department_title')
    new_title = data.get('new_title')
    new_color = data.get('color')
    new_motto = data.get('motto')
    new_logo = data.get('logo')
    
    if not department_title:
        return jsonify({"msg": "Department title is required"}), 400
    
    department = Department.query.filter_by(title=department_title).first()
    
    try:
        StructureManager.update_department(department=department, new_title=new_title, new_color=new_color, new_motto=new_motto, new_logo=new_logo)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    return jsonify({"msg": "Department updated"}), 200


@api.route('/structure/departments', methods=['DELETE'])
@admin_only
def delete_department():
    """Department deletion endpoint
    
    This endpoint allows the deletion of a department
    ---
    
    operationId: delete_department
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
                    required: [department_title]
                    properties:
                        department_title:
                            type: string
                            example: Resources
    responses:
        200:
            description: Department deleted
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Department deleted
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    data = request.get_json()
    department_title = data.get('department_title')
    
    if not department_title:
        return jsonify({"msg": "Department title is required"}), 400
    
    department: Department = Department.query.filter_by(title=department_title).first()
    
    if not department:
        return jsonify({"error": "Department not found"}), 400
    
    department.delete()
    
    return jsonify({"msg": "Department deleted"}), 200