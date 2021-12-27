from flask import render_template, request, Blueprint, jsonify
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db

data = Blueprint('data', __name__)

from corporation.data.api.api import *




