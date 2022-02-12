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
from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

@not_logged_in_only
@security.route("/reset_password", methods=['GET', 'POST'])
def reset_request():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    form = RequestResetForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        send_reset_email(user)
        flash('An email has been sent with instruction to reset your password', 'info')
        return redirect(url_for('security.login'))
    return render_template('security/reset_request.html', title="Reset Password", form=form)

@not_logged_in_only
@security.route("/reset_password/<token>", methods=['GET', 'POST'])
def reset_token(token):
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    user = User.verify_reset_token(token)
    if user is None:
        flash('That is an invalid or expired token', 'warning')

    form = ResetPasswordForm()

    if form.validate_on_submit():
        user.password = form.password.data
        flash(f'Your password has been updated! You can now login.', 'success')
        return redirect(url_for('security.login'))

    return render_template('user/reset_token.html', title="Reset Password", form=form)



@not_logged_in_only
@security.route("/confirm_email/<token>", methods=['GET', 'POST'])
def confirm_email(token):
    if current_user.is_authenticated:
        return redirect(url_for('security.login'))

    user = User.verify_security_token(token)
    if user is None:
        flash('This is an invalid or expired token', 'warning')
    else:
        user.email_confirmed = True
        db.session.commit()
        flash('Email confirmed, please login!', 'success')

    return redirect(url_for('security.login'))
