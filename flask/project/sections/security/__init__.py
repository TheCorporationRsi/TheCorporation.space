from flask import Blueprint

security = Blueprint('security', __name__)


from project.sections.security import login
from project.sections.security import recovery
from project.sections.security import register
from project.sections.security import tasks
