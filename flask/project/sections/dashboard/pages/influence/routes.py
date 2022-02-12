from flask import render_template, request, Blueprint, flash, url_for, redirect
from project.sections.dashboard.pages.influence.forms import MyForm
from flask_login import current_user, login_required
from project import db, scheduler
from project.sections.dashboard.pages.influence.events import *
from project.sections.dashboard.pages.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
from project.models import User, Role, Division
from sqlalchemy import func
from project.sections.dashboard import dashboard

from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

@CORP_only
@dashboard.route("/dashboard/influence", methods=['GET'])
def influence_page():

    return render_template('dashboard/pages/user/influence.html')

@CORP_only
@dashboard.route("/dashboard/influence/update_weight", methods=['GET', 'POST'])
def weight_form_submition():
    
    weight_form = Divisions_weight(prefix = "weight")
    if weight_form.validate_on_submit():
        for weight in weight_form.weights:
            role = Role.query.filter_by(division_id= weight.division.data, div_member= True).first()
            link = Rolevsuser.query.filter_by(user_id = current_user.id , role_id = role.id).first()
            link.weight = weight.weight.data
            db.session.commit()

        flash(f'Sucessful set the weight!', 'success')
    
    return render_template("dashboard/modules/influence/weight_form.html", weight_form=weight_form)

@CORP_only
@dashboard.route("/dashboard/influence/update_influence_form", methods=['GET', 'POST'])
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
    
    return render_template("dashboard/modules/influence/influence_form.html", inf_form=inf_form)

@CORP_only
@dashboard.route("/dashboard/influence/info", methods=['GET'])
def influence_info():
    
    return render_template("dashboard/modules/influence/info_table.html")

@CORP_only
@dashboard.route("/dashboard/influence/weight_graph", methods=['GET'])
def influence_graph():
    
    return render_template("dashboard/modules/influence/graph.html")