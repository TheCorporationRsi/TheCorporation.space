from flask import Blueprint

dashboard = Blueprint('dashboard', __name__)


from corporation.dashboard.account import routes
