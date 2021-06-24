from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division
from corporation.users.forms import RegistrationForm, LoginForm, UpdateAccountForm, RequestResetForm, ResetPasswordForm, inf_Form, Divisions_weight
from corporation.users.utils import save_picture, send_reset_email, send_confirmation_email
from flask_discord import requires_authorization
from corporation.data.scraping import RSI_account
from sqlalchemy import func
from corporation.users import users


@scheduler.task("interval", id="password attempt", minutes = 30)
def reset_login_timer():
    users = User.query.filter(User.login_attempt >= 1).all()
    for user in users:
        user.login_attempt = 0
    print("Reset login attempt timer!")