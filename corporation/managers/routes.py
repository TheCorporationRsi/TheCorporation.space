from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, User_Role, Department
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form

from flask import Blueprint

managers = Blueprint('managers', __name__)


@managers.route("/user_manager", methods=['GET', 'POST'])
@login_required
def user_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    page = request.args.get('page', 1, type=int)
    users = User.query.order_by(User.id.desc()).paginate(page= page, per_page=100)
    
    return render_template("managers/user_manager.html", title = "User manager", users = users)


#================================================= Role =========================================================
@managers.route("/role_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_manager(department, division):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    form = Role_Form()
    if form.validate_on_submit():
        if form.division.data:
            department = Division.query.filter_by(id = form.division.data.id).first()
            role = Role(title= form.title.data, division= form.division.data, department= department ,created_by= current_user.id)
        else:
            role = Role(title= form.title.data, created_by= current_user.id)
        db.session.add(role)
        db.session.commit()
        flash('Role has been created!', 'success')
        return redirect(url_for('managers.role_manager'))
    
    if department == 0 and division == 0:
        roles = Role.query.order_by(Role.title).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division).order_by(Role.title).all()
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).order_by(Role.title).all()
        
    if current_user.RSI_handle == 'Cyber-Dreamer':
        divisions = Division.query.order_by(Division.title).all()
        departments = Department.query.order_by(Department.title).all()
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles,  form=form, User_Role = User_Role, divisions = divisions, departments = departments, currentdiv = division, currentdep = department)


#================================================= Division =========================================================

@managers.route("/division_manager", defaults={"department": 0}, methods=['GET', 'POST'])
@managers.route("/division_manager/<int:department>", methods=['GET', 'POST'])
@login_required
def division_manager(department):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    form = Division_Form()
    if form.validate_on_submit():
        division = Division(title= form.title.data, department= form.department.data ,created_by= current_user.id)
        db.session.add(division)
        db.session.commit()
        
        division_id = division.id
        department_id = division.department.id
        div_head = Role(title= form.title.data + " Head", div_head = True , created_by = current_user.id , department_id = department_id, division_id = division_id)
        div_proxy = Role(title= form.title.data + " Proxy", created_by = current_user.id , department_id = department_id, division_id = division_id )
        db.session.add(div_head)
        db.session.add(div_proxy)
        db.session.commit()
        flash('Division has been created!', 'success')
        return redirect(url_for('managers.division_manager'))
    
    if department == 0:
        divisions = Division.query.order_by(Division.department_id).all()
    elif department > 0:
        divisions = Division.query.filter_by(department_id = department).order_by(Division.title).all()
        
    if current_user.RSI_handle == 'Cyber-Dreamer':
        departments = Department.query.order_by(Department.title).all()
    
    return render_template("managers/division_manager.html", title = "Division manager", divisions = divisions,  form=form, User_Role = User_Role, departments = departments, currentdep = department)


""" 
@managers.route("/division_manager/<int:division_id>/delete", methods=['GET', 'POST'])
@login_required
def delete_division(division_id):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    division = Division.query.get_or_404(division_id)
    db.session.delete(division)
    db.session.commit()
    flash('Division has been deleted!', 'success')
    return redirect(url_for('managers.division_manager'))
"""

#================================================= Department =========================================================


@managers.route("/department_manager", methods=['GET', 'POST'])
@login_required
def department_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    
    form = Department_Form()
    if form.validate_on_submit():
        department = Department(title= form.title.data, created_by= current_user.id)
        db.session.add(department)
        db.session.commit()
        
        department_id = department.id
        dp_head = Role(title= form.title.data + " Head", dep_head = True , created_by = current_user.id , department_id = department_id )
        dp_proxy = Role(title= form.title.data + " Proxy", created_by = current_user.id , department_id = department_id )
        db.session.add(dp_head)
        db.session.add(dp_proxy)
        db.session.commit()
        flash('The Department has been created!', 'success')
        return redirect(url_for('managers.department_manager'))
    
    departments = Department.query.order_by(Department.title).all()
    return render_template("managers/department_manager.html", title = "Department manager", departments = departments,  form=form, User_Role = User_Role)


""" 
@managers.route("/department_manager/<int:department_id>/delete", methods=['GET', 'POST'])
@login_required
def delete_department(department_id):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    department = Department.query.get_or_404(department_id)
    db.session.delete(department)
    db.session.commit()
    flash('Departemnt has been deleted!', 'success')
    return redirect(url_for('managers.department_manager'))

"""

#================================================= Other =========================================================

@managers.route("/erkul")
def erkul():
    return render_template("tool/erkul.html", title = "Erkul.games")