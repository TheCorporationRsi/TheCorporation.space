from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User

data = Blueprint('data', __name__)




@data.route('/countries')
def countrydic():
	res = User.query.all()
	list_countries = [r.as_dict() for r in res]
	return jsonify(list_countries)
