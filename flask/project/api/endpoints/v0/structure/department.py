from .... import api
from flask import jsonify, request
from .....models import User, Department, Division
import jwt
from ....security_wraps import admin_only, manager_only
from ..... import db

from flask_login import current_user, login_required


from ....controller.structure_controller import add_department


@admin_only
@api.route('/departments', methods=["GET"])
def departments():
    departments = Department.query.all()
    
    list_dep = [r.as_dict() for r in departments]
    
    
    return jsonify(list_dep)


@admin_only
@api.route('/departments', methods=["POST"])
def create_department():
    dep_name = request.args.get('department_title')
    dep_color = request.args.get('department_color')
    
    if dep_name and dep_color:
        if add_department(dep_name, dep_color):
            return jsonify({'success': "Department created"})
        else:
            return jsonify({'error': "Error while adding department"})
    else:
        return jsonify({'error': "Missing argument"})
