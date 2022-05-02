from .... import api
from flask import jsonify, request
from .....models import User, Department, Division
import jwt
from ....security_wraps import admin_only, manager_only
from ..... import db

from flask_login import current_user, login_required


from ....controller.structure_controller import add_division


@admin_only
@api.route('/divisions', methods=["GET"])
def divisions():
    divisions = Division.query.all()
    
    list_div = [r.as_dict() for r in divisions]
    
    return jsonify(list_div)


@admin_only
@api.route('/divisions', methods=["POST"])
def create_division():
    div_name = request.args.get('division_title')
    division_motto = request.args.get('division_motto')
    dep_id = request.args.get('department_id')
    
    if div_name and division_motto and dep_id:
        
        if add_division(div_name, dep_id, division_motto):
            return jsonify({'success': "Department created"})
        else:
            return jsonify({'error': "Error while adding division"})
    else:
        return jsonify({'error': "Missing argument"})