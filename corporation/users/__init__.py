from flask import Blueprint

users = Blueprint('users', __name__)


from corporation.users import account
from corporation.users import login
from corporation.users import recovery
from corporation.users import register
from corporation.users import tasks
