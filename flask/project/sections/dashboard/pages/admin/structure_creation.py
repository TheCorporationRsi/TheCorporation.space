from flask import render_template, request, Blueprint, flash, url_for, redirect
from project.sections.dashboard.pages.influence.forms import MyForm
from flask_login import current_user, login_required
from project import db, scheduler
from project.sections.dashboard.pages.influence.events import *
from project.sections.dashboard.pages.account.forms import UpdateAccountForm, inf_Form, Divisions_weight
from project.models import User, Role, Division, Department
from sqlalchemy import func
from project.sections.dashboard import dashboard

from project.api.security_wraps import admin_only, manager_only, not_logged_in_only, CORP_only

from project.api.controller.structure_controller import add_department, add_division

from .forms import add_department_form, add_division_form

@admin_only
@dashboard.route("/dashboard/admin/structure_creation", methods=['GET'])
def structure_creation_page():

    return render_template('dashboard/pages/admin/structure_creation.html')



@admin_only
@dashboard.route("/dashboard/modules/admin/add_department", methods=['GET', 'POST'])
def add_departments_form_submition():
    
    form = add_department_form(prefix = "department")
    if form.validate_on_submit():
        add_department(form.title.data, form.color.data)

        flash(f'Sucessfully created the department!', 'success')
        return redirect(url_for('dashboard.add_departments_form_submition'))
    
    return render_template("dashboard/modules/admin/add_department.html", form=form)


@admin_only
@dashboard.route("/dashboard/modules/admin/add_division", methods=['GET', 'POST'])
def add_divisions_form_submition():
    
    form = add_division_form(prefix = "division")
    if form.validate_on_submit():
        
        department = Department.query.filter_by(title = form.department_title.data).first()
        
        if department:
            add_division(form.title.data, department.id, form.motto.data)
            flash(f'Sucessfully created the division!', 'success')
            return redirect(url_for('dashboard.add_divisions_form_submition'))
    
    return render_template("dashboard/modules/admin/add_division.html", form=form)