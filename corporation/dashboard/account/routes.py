from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy.orm import query
from corporation import db, bcrypt, discord, scheduler
from corporation.models import User, Post, Role, Rolevsuser, Tribute, Division
from corporation.dashboard.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
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

@dashboard.route("/account/update_weight", methods=['GET', 'POST'])
@login_required
def weight_form_submition():
    
    weight_form = Divisions_weight(prefix = "weight")
    if weight_form.validate_on_submit():
        for weight in weight_form.weights:
            role = Role.query.filter_by(division_id= weight.division.data, div_member= True).first()
            link = Rolevsuser.query.filter_by(user_id = current_user.id , role_id = role.id).first()
            link.weight = weight.weight.data
            db.session.commit()

        flash(f'Sucessful set the weight!', 'success')
    
    return render_template("user/account_modules/weight_form.html", weight_form=weight_form)

@dashboard.route("/account/update_influence_form", methods=['GET', 'POST'])
@login_required
def influence_form_submition():
    
    inf_form = inf_Form(prefix="influence")
    if inf_form.validate_on_submit():
        receiver = User.query.filter(func.lower(User.RSI_handle) == func.lower(inf_form.RSI_handle.data)).first()

        sent = current_user.send_tribute(receiver=receiver, amount=inf_form.amount.data, message = inf_form.message.data )
        if sent == 0:
            flash(f'Sucessful transfer of ' + str(inf_form.amount.data) + ' influence to ' + receiver.RSI_handle, 'success')
        else: 
            flash(f'error', 'danger')
        return redirect(url_for('dashboard.influence_form_submition'))
    
    return render_template("user/account_modules/influence_form.html", inf_form=inf_form)