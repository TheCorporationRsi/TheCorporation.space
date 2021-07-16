from flask import Blueprint

security = Blueprint('security', __name__)


from corporation.security import login
from corporation.security import recovery
from corporation.security import register
from corporation.security import tasks
