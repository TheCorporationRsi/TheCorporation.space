from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User
from flask_login import current_user, login_required

data = Blueprint('data', __name__)




@data.route('/data/users')
@login_required
def users_dict():
	res = User.query.all()
	list_users = [r.as_dict() for r in res]
	return jsonify(list_users)
