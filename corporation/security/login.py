from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division
from corporation.security.forms import RegistrationForm, LoginForm, RequestResetForm, ResetPasswordForm
from corporation.security.utils import save_picture, send_reset_email, send_confirmation_email
from flask_discord import requires_authorization
from corporation.data.scraping import RSI_account
from sqlalchemy import func
from corporation.security import security


@security.route("/discord/auth/<int:type>")
def discord_login(type):
    if current_user.is_authenticated and type == 1:
        logout_user()
        return redirect(url_for('main.home'))

    return discord.create_session()


@security.route("/discord_callback")
def callback():
    
    if current_user.is_authenticated:
        discord.callback()
        user = discord.fetch_user()
        user_account = User.query.filter_by(RSI_handle=current_user.RSI_handle).first()
        user_account.discord_id = user.id
        user_account.discord_username = user.username+'#' + user.discriminator

        if user.id == 217337301364244480:
            user_account.security = 5

        db.session.commit()
        discord.revoke()
        current_user.upload_discord_roles()
        current_user.update_discord_roles()
        return redirect(url_for('dashboard.account'))

    try:
        discord.callback()
        user = discord.fetch_user()
        user_account = User.query.filter_by(discord_id=user.id).first()
    except:
        return redirect(url_for("security.login"))
    

    if user_account:
        user_account.discord_username = user.username+'#' + user.discriminator
        db.session.commit()
        discord.revoke()
        login_user(user_account, remember=False)
        return redirect(url_for('dashboard.account'))

    else:
        discord.revoke()
        return redirect(url_for('security.register'))



@security.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter(func.lower( User.RSI_handle) == func.lower(form.RSI_handle.data)).first()
        

        if user and user.test_password(password=form.password.data):
            user.update_info()
            
            if user.email_confirmed == False:
                send_confirmation_email(user)
                flash(
                    'Login Unsuccessful. Please check your email for verification', 'danger')
                return redirect(url_for('security.login'))

            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('dashboard.account'))
        else:
            flash('Login Unsuccessful. Please check RSI handle and password', 'danger')
    return render_template("user/login.html", title="Login", form=form)


@security.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.home'))