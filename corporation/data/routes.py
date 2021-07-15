from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
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


