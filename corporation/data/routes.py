from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division, Funding
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db

data = Blueprint('data', __name__)


@data.route('/data/users')
@login_required
def users_dict():
    res = User.query.all()
    list_users = [r.as_dict() for r in res]
    return jsonify(list_users)


@data.route('/data/departments')
@login_required
def dep_dict():
    res = Department.query.all()
    list_departments = [r.as_dict() for r in res]
    return jsonify(list_departments)


@data.route('/data/divisions')
@login_required
def div_dict():
    res = Division.query.all()
    list_Divisions = [r.as_dict() for r in res]
    return jsonify(list_Divisions)


@data.route('/citizen/<string:handle>')
def citizen_dict(handle):
    user = RSI_account(handle).has_json()
    return jsonify(user)


@data.route('/data/fundings_hourly')
def fund_hour_dict():
    fundings = Funding.query.order_by(Funding.date).all()
    for fund in fundings:
        if fund.fund == 18:
            fund.fund = 0
    db.session.commit()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@data.route('/data/fundings_hourly/<int:year>')
def fund_year_hour_dict(year):

    fundings = Funding.query.filter(extract('year', Funding.date) == year).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@data.route('/data/fundings')
def fund_dict():
    fundings = Funding.query.filter(extract('hour', Funding.date) == 18).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@data.route('/data/fundings/<int:year>')
def fund_year_dict(year):

    fundings = Funding.query.filter(and_(extract('year', Funding.date) == year, extract('hour', Funding.date) == 18)).order_by(Funding.date).all()
    list_funding = [r.as_dict() for r in fundings]
    return jsonify(list_funding)


@data.route('/data/fundings/graph_data/<string:type>')
def fund_dict_graph(type):
    if type == "citizens":
        fundings = Funding.query.filter(and_(Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    elif type == "both":
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None, Funding.citizens != 0, Funding.citizens != None)).order_by(Funding.date).all()
    else:
        fundings=Funding.query.filter(and_(Funding.fund != 0, Funding.fund != None)).order_by(Funding.date).all()
    list_funding=[r.as_dict() for r in fundings]
    return jsonify(list_funding)
