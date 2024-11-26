from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

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
                        type: object
                        properties:
                            title:
                                type: string
                                example: Resources

    """
    
    departments = current_user.departments
    departments_list = {}
    
    for department in departments:
        
        departments_list.append({
            "title": department.title,
            "color": department.color,
            "motto": department.motto,
            "logo": department.logo,
            "weight": department.get_weight(current_user)
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
                        type: object
                        properties:
                            title:
                                type: string
                                example: Development

    """
    
    divisions = current_user.divisions
    divisions_list = {}
    
    for division in divisions:
        divisions_list.append({
            "title": division.title,
            "color": division.color,
            "department": division.department.title,
            "logo": division.logo,
            "weight": division.get_weight(current_user)
        })
    
    return jsonify(divisions_list), 200


@api.route('/structure/profile/roles', methods=['GET'])
@CORP_only
def user_roles():
    """List of all your roles
    
    Returns a list of all the current user's roles
    ---
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
                        type: object
                        properties:
                            title:
                                type: string
                                example: Development member
        401:
            $ref: "#/components/responses/unauthorized"
    """
    
    roles = current_user.roles
    roles_list = {}
    
    for role in roles:
        roles_list.append({
            "title": role.title,
            "color": role.color,
            "department": role.department.title,
            "division": role.division.title
        })
    
    return jsonify(roles_list), 200

