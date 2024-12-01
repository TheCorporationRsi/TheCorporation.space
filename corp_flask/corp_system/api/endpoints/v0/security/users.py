from ...security_wraps import (
    admin_only,
    manager_only,
    not_logged_in_only,
    Confirmed_RSI_only,
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

from corp_system.controllers.security_manager import SecurityManager

from corp_system import limiter

from corp_system.models import User


@api.route("/users", methods=["GET"])
@admin_only
def get_users():
    """Users list

    This endpoint returns all the users in the system
    ---

    operationId: get_users
    tags:
        - Security
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Login was successfull
            content:
                application/json:
                    schema:
                        type: array
                        items:
                            type: object
                            properties:
                                RSI_handle:
                                    type: string
                                    example: Cyber-Dreamer
                                picture:
                                    type: string
                                    example: https://robertsspaceindustries.com/media/0p1xj2a2x3jxur/profile.jpg
                                RSI_confirmed:
                                    type: boolean
                                    example: True
                                CORP_confirmed:
                                    type: boolean
                                    example: True
                                disabled:
                                    type: boolean
                                    example: False
                                security_level:
                                    type: integer
                                    example: 3

        400:
            $ref: "#/components/responses/invalid"

    """
    users: list[User] = User.query.all()

    users_list = []

    for user in users:
        users_list.append(
            {
                "RSI_handle": user.RSI_handle,
                "picture": user.image_link,
                "RSI_confirmed": user.RSI_confirmed,
                "CORP_confirmed": user.CORP_confirmed,
                "disabled": user.disabled,
                "security_level": user.security_level,
            }
        )

    return jsonify(users_list), 200


@api.route("/users/<username>", methods=["GET"])
@admin_only
def get_user(username):
    """User info

    This endpoint returns the information on a user
    ---

    operationId: get_user
    tags:
        - Security
    security:
        - corp_access_pass: []
    responses:
        200:
            description: Login was successfull
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            RSI_handle:
                                    type: string
                                    example: Cyber-Dreamer
                            picture:
                                type: string
                                example: https://robertsspaceindustries.com/media/0p1xj2a2x3jxur/profile.jpg
                            RSI_confirmed:
                                type: boolean
                                example: True
                            CORP_confirmed:
                                type: boolean
                                example: True
                            disabled:
                                type: boolean
                                example: False
                            security_level:
                                type: integer
                                example: 3
                            roles:
                                type: array
                                items:
                                    type: object
                                    properties:
                                        title:
                                            type: string
                                            example: Admin
                                        color:
                                            type: string
                                            example: #FF0000
                            enabled_2fa:
                                type: boolean
                                example: True
                            RSI_verification_token:
                                type: string
                                example: 123456


        400:
            $ref: "#/components/responses/invalid"

    """
    user: User = User.query.filter_by(RSI_handle=username).first()

    if not user:
        return jsonify({"msg": "User not found"}), 400

    users_info = {
        "RSI_handle": user.RSI_handle,
        "picture": user.image_link,
        "RSI_confirmed": user.RSI_confirmed,
        "CORP_confirmed": user.CORP_confirmed,
        "disabled": user.disabled,
        "security_level": user.security_level,
        "roles": [
            {
                "title": role.title,
                "color": role.color,
            }
            for role in user.roles
        ],
        "enabled_2fa": user.Enabled_2FA,
        "RSI_verification_token": user.RSI_verification_token,
    }

    return jsonify(users_info), 200


@api.route("/users/<username>", methods=["DELETE"])
@admin_only
def delete_user(username):
    """User delete

    This endpoint delete a user
    ---

    operationId: delete_user
    tags:
        - Security
    security:
        - corp_access_pass: []
    responses:
        200:
            description: User delete
        400:
            $ref: "#/components/responses/invalid"

    """
    user: User = User.query.filter_by(RSI_handle=username).first()

    if not user:
        return jsonify({"msg": "User not found"}), 400

    user.delete()

    return jsonify({"msg": "User deleted"}), 200
