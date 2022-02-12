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

from .forms import add_department_form, add_division_form, Dep_Form, Div_Form

@admin_only
@dashboard.route("/dashboard/admin/structure", methods=['GET'])
def structure_page():

    return render_template('dashboard/pages/admin/structure.html')



@admin_only
@dashboard.route("/dashboard/modules/admin/departments", methods=['GET', 'POST'])
def departments_form_submition():
    
    department_form = Dep_Form(prefix="department")
    if department_form.validate_on_submit():
        department_id = department_form.department_id.data
        department = Department.query.filter_by(id=department_id).first()
        department.title = department_form.title.data
        department.color = department_form.color.data
        db.session.commit()
        department.update()
        
        print("maybe here")
        
        return redirect(url_for('dashboard.departments_form_submition'))
    
    division_form = Div_Form(prefix="division")
    if division_form.validate_on_submit():
        division_id = division_form.division_id.data
        division = Division.query.filter_by(id=division_id).first()
        division.title = division_form.title.data
        division.motto = division_form.motto.data
        db.session.commit()
        division.update()
        
        print("here")
        
        return redirect(url_for('dashboard.departments_form_submition'))
    
    return render_template("dashboard/modules/admin/departments.html", department_form=department_form, division_form=division_form)