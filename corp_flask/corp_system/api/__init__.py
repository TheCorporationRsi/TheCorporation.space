from flask import Blueprint

api = Blueprint('api', __name__)

from .endpoints import api_v0

api.register_blueprint(api_v0)

#from . import endpoints
#from . import bots
