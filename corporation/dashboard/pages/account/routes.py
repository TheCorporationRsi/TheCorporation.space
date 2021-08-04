from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division
from corporation.dashboard.pages.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
from corporation.dashboard.utils import save_picture
from flask_discord import requires_authorization
from corporation.data.scraping import RSI_account
from sqlalchemy import func
from corporation.dashboard import dashboard



@dashboard.route("/user/update", methods=['GET', 'POST'])
@login_required
def update_RSI_info():

    current_user.update_info()

    return redirect(url_for('dashboard.account'))

@dashboard.route("/dashboard", methods=['GET', 'POST'])
@login_required
def dashboard_link():
    
    return render_template("dashboard/dashboard.html", title="Account")


#=======================================================================================
@dashboard.route("/account", methods=['GET', 'POST'])
@login_required
def account():
    
    return render_template("user/account.html", title="Account")

