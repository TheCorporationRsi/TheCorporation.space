from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department, User, Role

from corp_system import db

from corp_system.controllers.structure_manager import StructureManager
from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/structure/profile', methods=['GET'])
@Confirmed_RSI_only
def user_profile():
    """Current user profile
    
    Returns the current user's profile
    ---
    
    operationId: get_user_profile
    tags:
        - Structure
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Profile info
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            RSI_handle:
                                type: string
                                example: Cyber-Dreamer
                            Moniker:
                                type: string
                                example: CyberDreamer
                            Picture:
                                type: string
                                example: Link
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    
    return jsonify({
        "RSI_handle": current_user.RSI_handle,
        "Moniker": current_user.RSI_moniker,
        "Picture": current_user.image_link,
        }), 200

@api.route('/structure/profile/departments', methods=['GET'])
@CORP_only
def user_departments():
    """List of all your departments
    
    Returns a list of the current user's departments
    ---
    
    operationId: get_user_departments
    tags:
        - Structure
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Departments
            content:
                application/json:
                    schema:
                        type: array
                        items:
                            type: object
                            properties:
                                title:
                                    type: string
                                    example: Resources
                                color:
                                    type: string
                                    example: #0083ff
                                motto:
                                    type: string
                                    example: We love building stuff
                                weight:
                                    type: integer
                                    example: 5
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    departments = current_user.departments
    departments_list = []
    
    for department in departments:
        
        departments_list.append({
            "title": department.title,
            "color": department.color,
            "motto": department.motto,
            "weight": department.get_weight(current_user),
        })
    
    return jsonify(departments_list), 200


@api.route('/structure/profile/divisions', methods=['GET'])
@CORP_only
def user_divisions():
    """List of all your division
    
    Return a list of the current user's division
    ---
    
    operationId: get_user_divisions
    tags:
        - Structure
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Divisions
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
                                department:
                                    type: string
                                    example: Resources
                                logo:
                                    type: string
                                    example: logo.svg
                                weight:
                                    type: integer
                                    example: 5
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    
    divisions = current_user.divisions
    divisions_list = []
    
    for division in divisions:
        divisions_list.append({
            "title": division.title,
            "color": division.color,
            "department": division.department.title,
            "logo": division.logo,
            "weight": division.get_weight(current_user),
        })
    
    return jsonify(divisions_list), 200


@api.route('/structure/profile/roles', methods=['GET'])
@Confirmed_RSI_only
def user_roles():
    """List of all your roles
    
    Returns a list of all the current user's roles
    ---
    operationId: get_user_roles
    tags:
        - Structure
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Roles
            content:
                application/json:
                    schema:
                        type: array
                        items:
                            type: object
                            properties:
                                title:
                                    type: string
                                    example: Development member
                                color:
                                    type: string
                                    example: #0083ff
                                type:
                                    type: string
                                    example: Leadership
                                department:
                                    type: string
                                    example: Resources
                                division:
                                    type: string
                                    example: Development
                                logo:
                                    type: string
                                    example: error
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    
    roles = current_user.roles
    roles_list = []
    
    for role in roles:
        roles_list.append({
            "title": role.title,
            "color": role.color,
            "logo": role.logo,
            "type": StructureManager.get_role_type(role=role),
            "department": role.department.title if role.department else None,
            "division": role.division.title if role.division else None
        })
    
    return jsonify(roles_list), 200

@api.route('/structure/profile/roles', methods=['POST'])
@admin_only
def add_user_role():
    """Add a role to the current user
    
    Adds a new role to the current user
    ---
    operationId: add_user_role
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
                        rsi_handle:
                            type: string
                            example: Cyber-Dreamer
                        role_title:
                            type: string
                            example: Development member
    responses:
        200:
            description: Role added
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Role added successfully
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.get_json()
    role_title = data.get('role_title')
    rsi_handle = data.get('rsi_handle')

    role = Role.query.filter_by(title=role_title).first()
    if not role:
        return jsonify({"message": "Role not found"}), 400
    
    user = User.query.filter_by(RSI_handle=rsi_handle).first()
    if not user:
        return jsonify({"message": "User not found"}), 400
    
    if role.title == "Corporateer":
        user.CORP_confirmed = True
        db.session.commit()

    user.add_role(role)
    
    user.update()

    return jsonify({"msg": "Role added"}), 200

@api.route('/structure/profile/roles', methods=['DELETE'])
@admin_only
def remove_user_role():
    """Remove a role from the current user
    
    Removes an existing role from the current user
    ---
    operationId: remove_user_role
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
                        rsi_handle:
                            type: string
                            example: Cyber-Dreamer
                        role_title:
                            type: string
                            example: Development member
    responses:
        200:
            description: Role removed
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Role removed
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.get_json()
    role_title = data.get('role_title')
    rsi_handle = data.get('rsi_handle')

    role = Role.query.filter_by(title=role_title).first()
    if not role:
        return jsonify({"message": "Role not found"}), 400
    
    user: User= User.query.filter_by(RSI_handle=rsi_handle).first()
    if not user:
        return jsonify({"message": "User not found"}), 400
    
    if role.title == "Corporateer":
        user.CORP_confirmed = False
        db.session.commit()

    user.remove_role(role)
    
    user.update()

    return jsonify({"message": "Role removed"}), 200

