from .. import api_v0 as api
from flask import jsonify
import jwt
from ...security_wraps import admin_only, manager_only, CORP_only
from sqlalchemy import func, extract, and_

from corp_system.tools.scraping.funding import RSI_funding

from corp_system.models import Funding


@api.route('/current_funding')
@CORP_only #TO BE CHANGED
def current_funding():
    """List of all influence system ranks
    
    This endpoint fetch the current funding from RSI website
    ---
    
    operationId: get_current_funding
    tags:
        - RSI Stats
    security:
        - cookieAuth: []
    responses:
        200:
            description: Transfer was successfull
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            fund:
                                type: integer
                                example: 0
                            citizens:
                                type: integer
                                example: 0
        401:
            $ref: "#/components/responses/unauthorized"

    """
    fundings = RSI_funding()
    return jsonify({
        "fund": fundings.fund,
        "citizens": fundings.citizens
        })


@api.route('/data/fundings')
@CORP_only
def fund_dict():
    fundings = Funding.query.order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@api.route('/data/fundings/<int:year>')
@CORP_only
def fund_year_dict(year):

    fundings = Funding.query.filter(and_(extract('year', Funding.date) == year, extract('hour', Funding.date) == 18)).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@api.route('/data/fundings/hourly')
@CORP_only
def fund_hour_dict():
    fundings = Funding.query.order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@api.route('/data/fundings/hourly/<int:year>')
@CORP_only
def fund_year_hour_dict(year):
    fundings = Funding.query.filter(extract('year', Funding.date) == year).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)



@api.route('/data/fundings/graph_data/<string:type>')
@CORP_only
def fund_dict_graph(type):
    if type == "citizens":
        fundings = Funding.query.filter(and_(Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    elif type == "both":
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None, Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    else:
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None)).order_by(Funding.date).all()
    list_funding=[r.as_dict() for r in fundings]
    return jsonify(list_funding)