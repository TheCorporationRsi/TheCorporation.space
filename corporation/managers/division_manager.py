from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser, Webpage_template
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form, Department_webpage_form
from corporation.managers.utils import save_background, save_logo
from corporation.managers import managers


@managers.route("/division_manager", defaults={"department": 0}, methods=['GET', 'POST'])
@managers.route("/division_manager/<int:department>", methods=['GET', 'POST'])
@login_required
def division_manager(department):
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    form = Division_Form(prefix="new")
    if form.submit.data and form.validate_on_submit():
        if department == 0:
            flash('You have to selct a department!', 'warning')
            return redirect(url_for('managers.division_manager', department = department))
        
        division = Division(title= form.title.data, department_id= department ,created_by= current_user.RSI_handle)
        db.session.add(division)
        db.session.commit()
        
        division_id = division.id
        department_id = division.department.id
        div_head = Role(title= form.title.data + " Head", div_head = True , created_by = current_user.RSI_handle , department_id = department_id, division_id = division_id)
        div_proxy = Role(title= form.title.data + " Proxy", div_proxy = True , created_by = current_user.RSI_handle , department_id = department_id, division_id = division_id )
        member = Role(title= form.title.data + " Member", div_member = True, created_by = current_user.RSI_handle , department_id = department_id, division_id = division_id )
        db.session.add(div_head)
        db.session.add(div_proxy)
        db.session.add(member)
        db.session.commit()
        flash('Division has been created!', 'success')
        return redirect(url_for('managers.division_manager', department = department))
    
    update_form = Div_Form(prefix="update")
    if update_form.update.data and update_form.update.data and update_form.validate_on_submit():
        division = Division.query.filter_by(id = update_form.division_id.data).first()
        division.title = update_form.title.data
        
        head = Role.query.filter_by(division_id = division.id, div_head= True).first()
        proxy = Role.query.filter_by(division_id = division.id, div_proxy= True).first()
        member = Role.query.filter_by(division_id = division.id, div_member= True ).first()
        
        head.title = division.title +" Head"
        proxy.title = division.title +" Proxy"
        member.title = division.title+" Member"
        
        db.session.commit()
        flash('The Division has been updated!', 'success')
    
    if department == 0:
        divisions = Division.query.order_by(Division.department_id).all()
    elif department > 0:
        divisions = Division.query.filter_by(department_id = department).order_by(Division.title).all()
        
    
    departments = Department.query.order_by(Department.title).all()
    
    return render_template("managers/division_manager.html", title = "Division manager", divisions = divisions,  form=form, departments = departments, currentdep = department, update_form=update_form)
