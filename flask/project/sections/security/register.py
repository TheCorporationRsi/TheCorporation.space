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
@security.route("/register", methods=['GET', 'POST'])
def register():

    form = RegistrationForm()
    if form.validate_on_submit():
        RSI_info = RSI_account(RSI_handle=form.RSI_handle.data)
        user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_info.RSI_handle)).first()
        if user and not user.registered:
            user.RSI_moniker=RSI_info.Moniker
            user.image_file=RSI_info.image_link
            user.RSI_number=RSI_info.citizen
            user.email=form.email.data
            user.password= form.password.data
            user.registered = True
        else:
            user = User(RSI_handle=RSI_info.RSI_handle, RSI_moniker=RSI_info.Moniker, image_file=RSI_info.image_link,
                    RSI_number=RSI_info.citizen, email=form.email.data, password=form.password.data, registered=True)
            db.session.add(user)
            
        db.session.commit()
        if send_confirmation_email(user) == -1:
            flash("Account was created, but wasn't able to send the email. Pls, try to login later to receive the verification email", "warning")
        else:
            flash(f'Your account has been created! Please look for a confirmation email.', 'success')

        user.update_info()

        
        return redirect(url_for('security.login'))
    return render_template("security/register.html", title="Register", form=form)

@login_required
@security.route("/register/verification", methods=['GET'])
def RSI_verification():
    
    current_user.update_info()
    if current_user.RSI_confirmed:
        return redirect(url_for('dashboard.dashboard_link'))
    else:
        flash(f'Please verify you RSI account with the following token', 'warning')
        return render_template("security/verification.html", title="Verification")
    