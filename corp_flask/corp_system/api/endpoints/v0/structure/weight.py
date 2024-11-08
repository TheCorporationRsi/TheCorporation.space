from ....security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.models import Inf_Rank, Division, Department

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@api.route('/structure/set_weight', methods=['POST'])
@CORP_only
def set_weight():
    division_title = request.json.get("division_title")
    amount = request.json.get("amount")
    
    division = Division.query.filter_by(title=division_title).first()
    if division is None:
        return jsonify({'msg': "Wrong division"}), 400
    
    if division not in current_user.divisions:
        return jsonify({'msg': "Not member of this division"}), 400
    
    if not isinstance(amount, int) or amount > 100 or amount < 0:
        return jsonify({'msg': "Amount must be integer between 1 and 100"}), 400
    
    try:
        division.set_weight(user=current_user, weight=amount)
    except ValueError as e:
        return jsonify({'msg': str(e)}), 400
    
    
    
    return jsonify({'msg': "Weight set!"}), 200
