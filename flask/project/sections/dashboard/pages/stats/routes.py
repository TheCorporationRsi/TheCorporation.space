from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from project import db, bcrypt, discord, scheduler
from project.models import User, Role, Division, Funding
from project.sections.dashboard.utils import save_picture
from flask_discord import requires_authorization
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func
from project.sections.dashboard import dashboard
import datetime
import json

import pathlib

from project.sections.dashboard.pages.stats.tasks import get_funding_stats

@dashboard.app_template_filter()
def currencyFormat(value):
    value = float(value)
    return "{:,.2f}".format(value)

@login_required
@dashboard.route("/dashboard/rsi_stats", methods=['GET'])
def rsi_stats():
    
    with open(str(pathlib.Path(__file__).parent.resolve())+'/temp_data.json') as json_file:
        data = json.load(json_file)
        current_fund = data['current_stats']['fund']
        current_citizens = data['current_stats']['citizens']
        daily_fund = data['current_stats']['daily_fund']
        daily_citizen = data['current_stats']['daily_citizens']

    return render_template('dashboard/pages/stats/rsi_stats_page.html', current_citizens = current_citizens, current_fund=current_fund, daily_fund=daily_fund , daily_citizen = daily_citizen )

@login_required
@dashboard.route("/dashboard/main", methods=['GET'])
def dashboard_stats():
    return render_template('dashboard/pages/main.html')