from flask import Blueprint

dashboard = Blueprint('dashboard', __name__)


from corporation.dashboard.pages.account import routes
from corporation.dashboard.pages.stats import routes
from corporation.dashboard.pages.influence import routes
