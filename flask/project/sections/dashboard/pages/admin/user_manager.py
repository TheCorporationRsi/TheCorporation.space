from flask import render_template, request, Blueprint, flash, url_for, redirect

from flask_login import current_user, login_required
from project import db, scheduler
from project.sections.dashboard.pages.influence.events import *
from project.models import User, Role, Division, Department
from sqlalchemy import func
from project.sections.dashboard import dashboard

from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

from project.api.controller.structure_controller import add_department, add_division

from .forms import add_department_form, add_division_form, Dep_Form, Div_Form

@admin_only
@dashboard.route("/dashboard/admin/users", methods=['GET'])
def user_manager():

    return render_template('dashboard/pages/admin/users.html')




@admin_only
@dashboard.route("/dashboard/modules/admin/users" ,methods=['GET'])
def users_list():
    handle = request.args.get('RSI_handle')
    department = request.args.get('department_id')
    division = request.args.get('division_id')
    manager = request.args.get('manager')
    corporateer = request.args.get('corporateer')
    
    users = None
    if handle:
        users = User.query.filter(func.lower(User.RSI_handle) == func.lower(handle)).order_by(User.RSI_handle).all()
    else:
        users = User.query.order_by(User.RSI_handle).all()
    
    if department:
        department = Department.query.filter_by(id=department).first()
        for user in users:
            if not user.is_member(department):
                users.remove(user)
                
    if division:
        division = Division.query.filter_by(id=division).first()
        for user in users:
            if not user.is_member(division):
                users.remove(user)
    
    if manager: 
        for user in users:
            if not user.is_manager():
                users.remove(user)
    
    if corporateer:
        for user in users:
            if not user.corp_confirmed:
                users.remove(user)
    
    return render_template('dashboard/modules/admin/users/users.html', users= users, handle = handle, department = department, division = division, manager = manager, corporateer = corporateer)


@admin_only
@dashboard.route("/dashboard/modules/admin/user_info/<string:id>", methods=['GET', 'POST'])
def user_info_form(id):
    
    
    return render_template("dashboard/modules/admin/users/user_info.html")