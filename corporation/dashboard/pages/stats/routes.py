from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division, Funding
from corporation.dashboard.utils import save_picture
from flask_discord import requires_authorization
from corporation.data.scraping import RSI_account
from sqlalchemy import func
from corporation.dashboard import dashboard
import datetime
import json

from corporation.dashboard.pages.stats.tasks import get_funding_stats

@dashboard.app_template_filter()
def currencyFormat(value):
    value = float(value)
    return "{:,.2f}".format(value)

@dashboard.route("/dashboard/rsi_stats", methods=['GET'])
@login_required
def rsi_stats():
    
    with open('/home/cyberdreamer/website/corp/corporation/dashboard/pages/stats/temp_data.json') as json_file:
        data = json.load(json_file)
        current_fund = data['current_stats']['fund']
        current_citizens = data['current_stats']['citizens']
        daily_fund = data['current_stats']['daily_fund']
        daily_citizen = data['current_stats']['daily_citizens']

    return render_template('dashboard/pages/rsi_stats_page.html', current_citizens = current_citizens, current_fund=current_fund, daily_fund=daily_fund , daily_citizen = daily_citizen )

@dashboard.route("/dashboard/main", methods=['GET'])
@login_required
def dashboard_stats():
    get_funding_stats()
    return render_template('dashboard/pages/main.html')