from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from sqlalchemy import func

from flask import jsonify, request

from corp_system.models import Inf_Rank, User
from corp_system.models.influence_system.auction import Inf_Auction  # Import Inf_Auction directly
from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/influence_system/auction', methods=['GET'])
@CORP_only
def list_auctions():
    """
    Get a list of all auctions
    ---
    operationId: list_auctions
    tags:
        - Influence System
    security:
        - corp_access_pass: []
    responses:
        200:
            description: List of all auctions
            content:
                application/json:
                    schema:
                        type: array
                        items:
                            type: object
                            properties:
                                id:
                                    type: string
                                    example: "123e4567-e89b-12d3-a456-426614174000"
                                title:
                                    type: string
                                    example: "Rare Ship Auction"
                                description:
                                    type: string
                                    example: "Auctioning a rare ship."
                                end_time:
                                    type: string
                                    format: date-time
                                start_time:
                                    type: string
                                    format: date-time
                                    example: "2024-06-01T12:00:00Z"
                                current_price:
                                    type: number
                                    example: 100
                                highest_bidder:
                                    type: string
                                    nullable: true
                                    example: "john_doe"
                                item_holder:
                                    type: string
                                    example: "jane_doe"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    auctions = Inf_Auction.query.all()
    auction_list = []
    for auction in auctions:
        def to_utc(dt):
            iso = dt.isoformat()
            return iso if iso.endswith('Z') else iso + 'Z'
        auction_list.append({
            "id": auction.id,
            "title": auction.title,
            "description": auction.description,
            "end_time": to_utc(auction.end_time),
            "start_time": to_utc(auction.start_time),
            "current_price": auction.current_price,
            "highest_bidder": auction.highest_bidder.RSI_handle if auction.highest_bidder else None,
            "item_holder": auction.item_holder.RSI_handle
        })
    return jsonify(auction_list), 200

@api.route('/influence_system/auction', methods=['POST'])
@manager_only
def create_auction():
    """
    Create a new auction
    ---
    operationId: create_auction
    tags:
        - Influence System
    security:
        - corp_access_pass: []
    requestBody:
        description: Auction creation data
        content:
            application/json:
                schema:
                    type: object
                    required: [title, description, end_time]
                    properties:
                        title:
                            type: string
                            example: "Rare Ship Auction"
                        description:
                            type: string
                            example: "Auctioning a rare ship."
                        end_time:
                            type: string
                            format: date-time
                            example: "2025-07-01T12:00:00Z"
                        department:
                            type: string
                            example: "Engineering"
                        division:
                            type: string
                            example: "Research Division"
    responses:
        201:
            description: Auction created successfully
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            id:
                                type: string
                                example: "123e4567-e89b-12d3-a456-426614174000"
                            title:
                                type: string
                                example: "Rare Ship Auction"
                            description:
                                type: string
                                example: "Auctioning a rare ship."
                            end_time:
                                type: string
                                format: date-time
                                example: "2025-07-01T12:00:00Z"
                            current_price:
                                type: number
                                example: 100
                            highest_bidder:
                                type: string
                                nullable: true
                                example: "john_doe"
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.json
    try:
        auction = InfluenceSystemManager.create_auction(
            item_name=data.get("title"),
            description=data.get("description"),
            end_time=data.get("end_time"),
            department=data.get("department"),
            division=data.get("division"),
            owner=current_user,
        )
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    return jsonify({'msg':"Auctioned"}), 200

@api.route('/influence_system/auction/bet', methods=['POST'])
@CORP_only
def place_bet():
    """
    Place a bet on an auction
    ---
    operationId: place_bet
    tags:
        - Influence System
    security:
        - corp_access_pass: []
    requestBody:
        description: Bet information
        content:
            application/json:
                schema:
                    type: object
                    required: [auction_id, amount]
                    properties:
                        auction_id:
                            type: string
                            example: "123e4567-e89b-12d3-a456-426614174000"
                        amount:
                            type: integer
                            example: 150
    responses:
        200:
            description: Bet placed successfully
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            msg:
                                type: string
                                example: Bet placed successfully!
        400:
            $ref: "#/components/responses/invalid"
        401:
            $ref: "#/components/responses/unauthorized"
    """
    data = request.json
    auction_id = data.get("auction_id")
    amount = data.get("amount")
    try:
        bet = InfluenceSystemManager.place_bid(
            user=current_user,
            auction_id=auction_id,
            bid_amount=amount
        )
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    return jsonify({'msg': "Bet placed successfully!"}), 200



