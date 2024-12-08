from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department, Role

from corp_system.controllers.structure_manager import StructureManager

from corp_system import db

@api.route('/structure/roles', methods=['GET'])
def roles():
    """List of all roles
    
    Returns a list of all the roles in the system
    ---
    
    operationId: get_roles
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
                                    example: Developer
                                color:
                                    type: string
                                    example: #0083ff
                                division:
                                    type: string
                                    example: Development
                                department:
                                    type: string
                                    example: Resources
                                discord_id:
                                    type: string
                                    example: 123456789012345678

    """
    roles: list[Role] = Role.query.all()
    roles_list: list[Role] = []
    
    for role in roles:
        roles_list.append({
            "title": role.title,
            "color": role.color,
            "division": role.division.title if role.division else None,
            "department": role.department.title if role.department else None,
            "discord_id": role.discord_id
        })
    
    return jsonify(roles_list), 200

@api.route('/structure/roles', methods=['POST'])
@admin_only
def create_role():
    """Create a new role
    
    Creates a new role in the system
    ---
    
    operationId: create_role
    tags:
        - Structure
    security:
        - corp_access_pass: []
    requestBody:
        required: true
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        title:
                            type: string
                            example: Developer
                        division_title:
                            type: string
                            example: Development
                        department_title:
                            type: string
                            example: Resources
    responses:
        201:
            description: Role created
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Role created
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.get_json()
    role_title=data['title'],
    division_title=data.get('division_title'),
    department_title=data.get('department_title')
    
    division = Division.query.filter_by(title=division_title).first()
    department = Department.query.filter_by(title=department_title).first()
    
    StructureManager.create_role(title=role_title, division=division, department=department)
    
    return jsonify({"msg": "Role created"}), 201

@api.route('/structure/roles', methods=['PATCH'])
@admin_only
def edit_role():
    """Edit an existing role
    
    Edits an existing role in the system
    ---
    
    operationId: update_role
    tags:
        - Structure
    security:
        - corp_access_pass: []
    requestBody:
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        role_title:
                            type: string
                            example: Developer
                        new_title:
                            type: string
                            example: Developer
                        new_color:
                            type: string
                            example: #0083ff
                        new_discord_id:
                            type: string
                            example: 123456789012345678
    responses:
        200:
            description: Role updated
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Role updated
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.get_json()
    
    role_title = data.get('role_title')
    new_title = data.get('new_title')
    new_color = data.get('new_color')
    new_discord_id = data.get('new_discord_id')
    
    if role_title:
        role: Role = Role.query.filter_by(title=role_title).first()
    else:
        jsonify({"msg": "Role title is required"}), 400
    
    try:
        StructureManager.update_role(role=role, new_title=new_title, new_color=new_color, new_discord_id=new_discord_id)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    
    return jsonify({"msg": "Role updated",}), 200

@api.route('/structure/roles', methods=['DELETE'])
@admin_only
def delete_role():
    """Delete an existing role
    
    Deletes an existing role in the system
    ---
    
    operationId: delete_role
    tags:
        - Structure
    security:
        - corp_access_pass: []
    requestBody:
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        role_title:
                            type: string
                            example: Developer
    responses:
        200:
            description: Role deleted
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Role deleted
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.get_json()
    role_title = data.get('role_title')
    if role_title:
        role: Role = Role.query.filter_by(title=role_title).first()
    
    if not role_title or not role:
        return jsonify({"msg": "Role not found"}), 404
    
    if StructureManager.get_role_type(role) == "Membership" or StructureManager.get_role_type(role) == "Leadership":
            jsonify({"msg": "Function roles cannot be deleted"}), 400
    
    role.delete()
    
    return jsonify({"msg": "Role deleted"}), 200

