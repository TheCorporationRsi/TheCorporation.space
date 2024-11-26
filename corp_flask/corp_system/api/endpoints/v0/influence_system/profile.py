from ...security_wraps import admin_only, manager_only, not_logged_in_only, Confirmed_RSI_only, CORP_only
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity, set_access_cookies, current_user, create_refresh_token, set_refresh_cookies
from .. import api_v0 as api

from flask import jsonify, request

from corp_system.controllers.influence_system_manager import InfluenceSystemManager
from corp_system.controllers.structure_manager import StructureManager

from corp_system.models import Department, Division, Inf_Tribute, Inf_Account, Inf_Tribute

@api.route('/influence_system/profile', methods=['GET'])
@CORP_only
def profile():
	"""Get influence system profile
	
	This endpoint provide profile information about the user that is currently connected
	---
	operationId: get_profile
	tags:
		- Influence System
	security:
		- corp_access_pass: []
	responses:
		200:
			description: Transfer was successful
			content:
				application/json:
					schema:
						type: object
						properties:
							tribute:
								type: integer
								example: 50
							rank:
								type: string
								example: 50
		401:
			$ref: "#/components/responses/unauthorized"

	"""
		
	account: Inf_Account = current_user.inf_account
	
	profile = {
			"tribute": account.tribute_amount,
			"rank": account.rank.title
	}
	return jsonify(profile), 200




@api.route('/influence_system/profile/<influence_type>/<type>/<title>', methods=['GET'])
@CORP_only
def current_influence(influence_type, type, title):
	"""Get current influence
	
	This endpoint provide the current amount of specified influence
	---
	operationId: get_influence
	tags:
		- Influence System
	security: 
        - corp_access_pass: []
	parameters:
		- 	in: path
			name: influence_type # Note the name is the same as in the path
			required: true
			schema:
				type: string
				enum: [influence, lifetime_influence]
    			example: influence
			description: type of influence
		- 	in: path
			name: type # Note the name is the same as in the path
			required: true
			schema:
				type: string
				enum: [all, division, department, general]
				example: all
			description: type of influence
		- 	in: path
			name: title # Note the name is the same as in the path
			required: true
			schema:
				type: string
				example: Development
			description: Department/Division title
	responses:
		200:
			description: Transfer was successful
			content:
				application/json:
					schema:
						type: string
						example: 2000
		401:
			$ref: "#/components/responses/unauthorized"

	"""
	department = None
	division = None
	general = False
	
	if type != None:
			if type == "division":
					if title != None:
							division = Division.query.filter_by(title=title).first()
							if division == None:
									return jsonify({'msg': "Division doesn't exist"}), 400
			elif type == "department":
					if title != None:
							department = Department.query.filter_by(title=title).first()
							if department == None:
									return jsonify({'msg': "Department doesn't exist"}), 400
			elif type == "general":
					general = True
			elif type == "all":
					pass
			else:
					return jsonify({'msg': "Please select a type"}), 400

	if influence_type == "influence":
			return jsonify(current_user.inf_account.current_influence(department=department, division=division, general=general)), 200
	elif influence_type == "lifetime_influence":
			return jsonify(current_user.inf_account.lifetime_influence(department=department, division=division, general=general)), 200
	else:
			return jsonify({'msg': "Please select influence type"}), 400


@api.route('/influence_system/profile/tribute_history/<type>/<request>/<int:page>', methods=['GET'])
@CORP_only
def sent_tribute(type, request, page):
	"""Get tribute transaction history
	
	This endpoint provide the tribute submission history
	---
	
	operationId: get_tribute_history
	tags:
		- Influence System
	security: 
        - corp_access_pass: []
	parameters:
		- 	in: path
			name: type # Note the name is the same as in the path
			required: true
			schema:
				type: string
				enum: [sent, received]
				example: sent
			description: sent/received
		- 	in: path
			name: request # Note the name is the same as in the path
			required: true
			schema:
				type: string
				enum: [all, page]
    			example: all
			description: page/all
		- 	in: path
			name: page # Note the name is the same as in the path
			required: true
			schema:
				type: string
				example: "0"
			description: page number
	responses:
		200:
			description: Acquired transaction history
			content:
				application/json:
					schema:
						type: array
						items:
							type: object
							properties:
								receiver:
									type: string
									example: Cyber-Dreamer
								amount:
									type: integer
									example: 50
								message:
									type: string
									example: Thanks for building this
								method:
									type: string
									example: Website
		400:
			$ref: "#/components/responses/invalid"
		401:
			$ref: "#/components/responses/unauthorized"

	"""
	
	if request == "all":
			if type == "sent":
					tributes = current_user.inf_account.sent_tributes
			elif type == "received":
					tributes = current_user.inf_account.received_tributes
	elif request == "page":
			if not isinstance(page, int):
					return jsonify({'msg': "Page must be integer"}), 400
			if type == "sent":
					tributes = Inf_Tribute.query.order_by(Inf_Tribute.created_on.desc()).filter_by(sender=current_user.inf_account).paginate(page=page, per_page=20, error_out=False)
			elif type == "received":
					tributes = Inf_Tribute.query.order_by(Inf_Tribute.created_on.desc()).filter_by(receiver=current_user.inf_account).paginate(page=page, per_page=20, error_out=False)
			else:
					return jsonify({'msg': "Please select the type of history"}), 400
	else:
			return jsonify({'msg': "Please select request type"}), 400    
	
	tributes_list = {}
	
	for tribute in tributes:
			tributes_list.append({
					"receiver": tribute.receiver.RSI_handle,
					"amount": tribute.amount,
					"message": tribute.message,
					"method": tribute.method
			})
			
	
	return jsonify(tributes_list), 200