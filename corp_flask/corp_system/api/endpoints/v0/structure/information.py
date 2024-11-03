from ....security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

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


@api.route('/structure/divisions', methods=['GET'])
def divisions():
    """List of all divisions
    
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
                    type: array
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
                        logo:
                            type: string
                            example: logo.svg
                        member_count:
                            type: integer
                            example: 50
                        leaders:
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
    
    divisions = Division.query.filter_by(hidden=False).all()
    divisions_list = []
    
    for division in divisions:
        
        divisions_list.append({
            "title": division.title,
            "color": division.color,
            "department_title": division.department.title,
            "motto": division.motto,
            "logo": division.logo,
            "leaders": [leader.RSI_handle for leader in division.leader_role.users],
            "proxys": [proxy.RSI_handle for proxy in division.proxy_role.users],
            "member_count": len(division.members)
        })
    
    return jsonify(divisions_list), 200

