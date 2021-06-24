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




@users.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(
            form.password.data).decode('utf-8')
        RSI_info = RSI_account(RSI_handle=form.RSI_handle.data)
        user = user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_info.RSI_handle)).first()
        if user:
            user.RSI_moniker=RSI_info.Moniker
            user.image_file=RSI_info.image_link
            user.RSI_number=RSI_info.citizen
            user.email=form.email.data
            user.password=hashed_password
            user.registered = True
        else:
            user = User(RSI_handle=RSI_info.RSI_handle, RSI_moniker=RSI_info.Moniker, image_file=RSI_info.image_link,
                    RSI_number=RSI_info.citizen, email=form.email.data, password=hashed_password, registered=True)
            db.session.add(user)
            
        db.session.commit()
        send_confirmation_email(user)

        role = Role.query.filter_by(title="Corporateer").first()
        user.update_info()

        flash(f'Your account has been created! Please look for a confirmation email.', 'success')
        return redirect(url_for('users.login'))
    return render_template("user/register.html", title="Register", form=form)