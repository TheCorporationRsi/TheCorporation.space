from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser, Webpage_template
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form, Department_webpage_form
from corporation.managers.utils import save_background, save_logo
from corporation.managers import managers

@managers.route("/role_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_manager(department, division):
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    form = Role_Form(prefix="new")
    if form.submit.data and form.validate_on_submit():
        if department > 0 and division > 0:
            division = Division.query.filter_by(id = division ).first()
            role = Role(title= form.title.data, division= division, department= department ,created_by= current_user.RSI_handle)
        elif department > 0:
            role = Role(title= form.title.data, department= department ,created_by= current_user.RSI_handle)
        else:
            role = Role(title= form.title.data, created_by= current_user.RSI_handle)
        db.session.add(role)
        db.session.commit()
        flash('Role has been created!', 'success')
        return redirect(url_for('managers.role_manager'))
    
    update_form = Role_edit_Form(prefix="update")
    if update_form.update.data and update_form.validate_on_submit():
        role = Role.query.filter_by(id = update_form.role_id.data).first()
        role.title = update_form.title.data
        
        db.session.commit()
        flash('The Role has been updated!', 'success')
    
    update_color_form = Role_edit_color_Form(prefix="update_color")
    if update_color_form.update.data and update_color_form.validate_on_submit():
        role = Role.query.filter_by(id = update_color_form.role_id.data).first()
        role.title = update_color_form.title.data
        role.color = update_color_form.color.data
        
        db.session.commit()
        flash('The Role has been updated!', 'success')
    
    if department == 0 and division == 0:
        roles = Role.query.order_by(Role.title).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division).order_by(Role.title).all()
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).order_by(Role.title).all()
        
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles, Role = Role,  form=form, currentdiv = division, currentdep = department, update_form=update_form, update_color_form=update_color_form)

