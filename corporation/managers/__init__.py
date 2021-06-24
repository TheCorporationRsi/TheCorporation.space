from flask import  Blueprint

managers = Blueprint('managers', __name__)

from corporation.managers import department_manager
from corporation.managers import division_manager
from corporation.managers import role_manager
from corporation.managers import user_manager
from corporation.managers import managers_tool