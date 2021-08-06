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

@dashboard.app_template_filter()
def currencyFormat(value):
    value = float(value)
    return "{:,.2f}".format(value)

class funding_last_data():
    "This is a person class"
    current = 0
    daily_fund = 0
    daily_citizen = 0
    time = 0

@dashboard.route("/dashboard/rsi_stats", methods=['GET'])
@login_required
def rsi_stats():
    
    one_hour = datetime.datetime.now() - datetime.timedelta(hours = 1)
    
    global funding_last_data
    if not funding_last_data.time == 0 and funding_last_data.time > one_hour:
        current_fund = funding_last_data.current
        daily_fund = funding_last_data.daily_fund
        daily_citizen = funding_last_data.daily_citizen
        
        return render_template('dashboard/pages/rsi_stats_page.html', current_fund=current_fund, daily_fund=daily_fund , daily_citizen = daily_citizen )
    
    list = Funding.query.order_by(Funding.id.desc()).all()
    current_fund = list[0]
    
    
    daily_fund = list[0].fund - list[23].fund
           
    daily_citizen = list[0].citizens - list[23].citizens
    
    funding_last_data.current = current_fund
    funding_last_data.daily_fund = daily_fund
    funding_last_data.daily_citizen = daily_citizen
    funding_last_data.time = datetime.datetime.now()
        

    return render_template('dashboard/pages/rsi_stats_page.html', current_fund=current_fund, daily_fund=daily_fund , daily_citizen = daily_citizen )

@dashboard.route("/dashboard/main", methods=['GET'])
@login_required
def dashboard_stats():

    return render_template('dashboard/pages/main.html')