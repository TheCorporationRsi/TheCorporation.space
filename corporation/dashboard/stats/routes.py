from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division
from corporation.dashboard.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
from corporation.dashboard.utils import save_picture
from flask_discord import requires_authorization
from corporation.data.scraping import RSI_account
from sqlalchemy import func
from corporation.dashboard import dashboard


@dashboard.route("/dashboard/rsi_stats", methods=['GET'])
@login_required
def rsi_stats():

    return render_template('dashboard/pages/rsi_stats_page.html')

@dashboard.route("/dashboard/main", methods=['GET'])
@login_required
def dashboard_stats():

    return render_template('dashboard/pages/main.html')