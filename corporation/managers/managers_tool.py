from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser, Webpage_template
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form, Department_webpage_form
from corporation.managers.utils import save_background, save_logo
from corporation.managers import managers




@managers.route("/managers/department/<int:department>", methods=['GET', 'POST'])
@login_required
def department_managers_tool(department):
    if not current_user.is_manager(department= department):
        return redirect(url_for('main.home'))
    
    department = Department.query.filter_by(id = department).first()
    return render_template("managers/department_tool.html", title = "Department manager", department = department)

@managers.route("/managers/managers/<int:department>/members/<string:user_handle>", methods=['GET', 'POST'])
@login_required
def user_info(department, user_handle):
    if not current_user.is_manager(department= department):
        return redirect(url_for('main.home'))
    
    user = User.query.filter_by(RSI_handle=user_handle).first()
    department = Department.query.filter_by(id = department).first()
    
    return render_template("managers/modules/user_info.html", user = user, department = department)