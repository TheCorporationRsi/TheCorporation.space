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


@dashboard.route("/dashboard/setup/user_manager", methods=['GET'])
@login_required
def user_manager():
    return render_template('dashboard/pages/setup/user_manager.html')