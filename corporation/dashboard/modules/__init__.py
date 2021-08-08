from flask import render_template, request, Blueprint, jsonify
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db

modules = Blueprint('modules', __name__)

from corporation.dashboard.modules.chart.graph import *
from corporation.dashboard.modules.chart.table import *
from corporation.dashboard.modules.manager_module.user_manager import *




