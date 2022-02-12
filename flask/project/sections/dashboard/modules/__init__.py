from flask import render_template, request, Blueprint, jsonify
from flask_login import current_user, login_required
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from project import db

modules = Blueprint('modules', __name__)

from project.sections.dashboard.modules.chart.graph import *
from project.sections.dashboard.modules.chart.table import *




