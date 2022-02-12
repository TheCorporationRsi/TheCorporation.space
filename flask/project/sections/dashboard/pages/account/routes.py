from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from project import db, bcrypt, discord, scheduler
from project.models import User, Role, Division
from project.sections.dashboard.pages.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
from project.sections.dashboard.utils import save_picture
from flask_discord import requires_authorization
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func
from project.sections.dashboard import dashboard
from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

@login_required
@dashboard.route("/user/update", methods=['GET', 'POST'])
@login_required
def update_RSI_info():

    current_user.update_info()

    return redirect(url_for('dashboard.account'))

@CORP_only
@dashboard.route("/dashboard", methods=['GET', 'POST'])
@login_required
def dashboard_link():
    
    return render_template("dashboard/dashboard.html", title="Account")




