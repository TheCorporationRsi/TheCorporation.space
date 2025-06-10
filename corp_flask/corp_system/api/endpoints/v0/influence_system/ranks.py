from ...security_wraps import (
    admin_only,
    manager_only,
    not_logged_in_only,
    Confirmed_RSI_only,
    CORP_only,
)
from flask_jwt_extended import (
    JWTManager,
    jwt_required,
    create_access_token,
    get_jwt_identity,
    set_access_cookies,
    current_user,
    create_refresh_token,
    set_refresh_cookies,
)
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank

from corp_system.controllers.influence_system_manager import InfluenceSystemManager


@api.route("/influence_system/ranks", methods=["GET"])
def ranks():
    """List of all influence system ranks

    Returns a list of all the ranks of the influence system
    ---

    operationId: get_ranks
    tags:
        - Influence System
    security: []
    responses:
        200:
            description: Request was successful
            content:
                application/json:
                    schema:
                        type: array
                        items:
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

    """

    ranks = Inf_Rank.query.all()
    rank_list = []

    for rank in ranks:
        rank_list.append(
            {
                "title": rank.title,
                "required_lifetime_influence": rank.required_lifetime_influence,
                "weekly_amount": rank.weekly_amount,
            }
        )

    return jsonify(rank_list), 200


# --- Admin endpoints for rank management ---


@api.route("/influence_system/ranks", methods=["POST"])
@admin_only
def create_rank():
    """Allow to edit a rank of the influence system 
    
    Create a new influence system rank (admin only)
    ---

    operationId: create_rank
    tags:
        - Admin
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
                        required_lifetime_influence:
                            type: integer
                        weekly_amount:
                            type: integer
    responses:
        200:
            description: Rank created
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Rank created
            
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    data = request.get_json()
    try:
        rank = InfluenceSystemManager.create_rank(
            title=data.get("title"),
            required_lifetime_influence=data.get("required_lifetime_influence"),
            weekly_amount=data.get("weekly_amount"),
        )
        return jsonify({"msg": "Rank created"}), 200
    except ValueError as e:
        return jsonify({"msg": str(e)}), 400


@api.route("/influence_system/ranks", methods=["PATCH"])
@admin_only
def edit_rank():
    """Allow to edit a rank of the influence system 
    
    Edit an existing influence system rank (admin only)
    ---

    operationId: edit_rank
    tags:
        - Admin
    security:
        - corp_access_pass: []
    requestBody:
        required: true
        content:
            application/json:
                schema:
                    type: object
                    required: [rank_title]
                    properties:
                        rank_title:
                            type: string
                            description: The current title of the rank to edit
                        title:
                            type: string
                            description: New title for the rank (optional)
                        required_lifetime_influence:
                            type: integer
                            description: New required lifetime influence (optional)
                        weekly_amount:
                            type: integer
                            description: New weekly amount (optional)
    responses:
        200:
            description: Rank updated
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Rank updated
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    data = request.get_json()
    try:
        rank = InfluenceSystemManager.edit_rank(
            rank_title=data.get("rank_title"),
            title=data.get("title"),
            required_lifetime_influence=data.get("required_lifetime_influence"),
            weekly_amount=data.get("weekly_amount"),
        )
        return jsonify({"msg": "Rank updated"}), 200
    except ValueError as e:
        return jsonify({"msg": str(e)}), 400


@api.route("/influence_system/ranks", methods=["DELETE"])
@admin_only
def delete_rank():
    """Allow to delete a rank of the influence system 
    
    Delete an influence system rank (admin only)
    ---

    operationId: delete_rank
    tags:
        - Admin
    security:
        - corp_access_pass: []
    requestBody:
        required: true
        content:
            application/json:
                schema:
                    type: object
                    required: [rank_title]
                    properties:
                        rank_title:
                            type: string
                            description: The title of the rank to delete
    responses:
        200:
            description: Rank deleted
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Rank deleted
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"

    """
    data = request.get_json()
    try:
        InfluenceSystemManager.delete_rank(data.get("rank_title"))
        return jsonify({"msg": "Rank deleted"}), 200
    except ValueError as e:
        return jsonify({"msg": str(e)}), 400
