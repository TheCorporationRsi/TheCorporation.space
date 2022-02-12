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

from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

@CORP_only
@dashboard.route("/dashboard/roles", methods=['GET'])
@login_required
def roles_section():

    return render_template('dashboard/pages/user/roles.html')