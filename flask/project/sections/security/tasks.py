from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from project import db, bcrypt, discord, scheduler
from project.models import User, Role, Division
from project.sections.security.forms import RegistrationForm, LoginForm, RequestResetForm, ResetPasswordForm
from project.sections.security.utils import save_picture, send_reset_email, send_confirmation_email
from flask_discord import requires_authorization
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func
from project.sections.security import security


@scheduler.task("interval", id="password attempt", minutes = 30)
def reset_login_timer():
    users = User.query.filter(User.login_attempt >= 1).all()
    for user in users:
        user.login_attempt = 0
    print("Reset login attempt timer!")