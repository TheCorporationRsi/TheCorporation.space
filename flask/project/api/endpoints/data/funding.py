from ... import api
from flask import jsonify
from ....models import User, Funding
import jwt
from ...security_wraps import admin_only, manager_only, CORP_only
from sqlalchemy import func, extract, and_
from flask_login import current_user, login_required
from project import db

from project.api.scraping.RSI.funding import RSI_funding

@CORP_only
@api.route('/current_funding')
def current_funding():
    fundings = RSI_funding()
    return jsonify(fundings.fund)

@CORP_only
@api.route('/data/fundings')
def fund_dict():
    fundings = Funding.query.filter(extract('hour', Funding.date) == 18).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)

@CORP_only
@api.route('/data/fundings/<int:year>')
def fund_year_dict(year):

    fundings = Funding.query.filter(and_(extract('year', Funding.date) == year, extract('hour', Funding.date) == 18)).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)

@CORP_only
@api.route('/data/fundings/hourly')
def fund_hour_dict():
    fundings = Funding.query.order_by(Funding.date).all()
    for fund in fundings:
        if fund.fund == 18:
            fund.fund = 0
    db.session.commit()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)

@CORP_only
@api.route('/data/fundings/hourly/<int:year>')
def fund_year_hour_dict(year):
    fundings = Funding.query.filter(extract('year', Funding.date) == year).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@CORP_only
@api.route('/data/fundings/graph_data/<string:type>')
def fund_dict_graph(type):
    if type == "citizens":
        fundings = Funding.query.filter(and_(Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    elif type == "both":
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None, Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    else:
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None)).order_by(Funding.date).all()
    list_funding=[r.as_dict() for r in fundings]
    return jsonify(list_funding)
    
    