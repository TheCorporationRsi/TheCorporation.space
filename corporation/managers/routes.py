from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form
from sqlalchemy.orm import contains_eager

from flask import Blueprint

managers = Blueprint('managers', __name__)

def security_test(user = 0, handle = None, division = 0, department = 0):
    if user > 0: 
        user = User.query.filter_by(id = user).first()
    else:
        user = User.query.filter_by(RSI_handle = handle).first()
    
    if user.RSI_handle == "Cyber-Dreamer" or user.security == 5:
        return True
    
    
    if division > 0:
        division = Division.query.filter_by(id = division).first()
        for role in division.roles:
            for link in role.members:
                if link.user == user and link.role.division_id == division.id and link.role.div_head :
                    return True
                
    elif department > 0:
        department = Department.query.filter_by(id = department).first()
        for role in department.roles:
            for link in role.members:
                if link.user == user and link.role.department_id == department.id and link.role.dep_head :
                    return True
    
    return False
    

@managers.route("/add_role/<int:user>/<int:role>", methods=['GET', 'POST'])
@login_required
def add_role(user, role, admin = 0):
    next_page = request.args.get('next')
    role = Role.query.filter_by(id = role).first()
    roles = Role.query.order_by(Role.title).all()
    
    user = User.query.filter_by(id = user).first()
    for therole in roles:
        for link in therole.members:
            if link.user == user and link.role == role :
                flash('User allready have the role!', 'danger')
                return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
            
    if security_test(user = current_user.id, division = role.division_id, department = role.department_id) == False or admin == 1:
        return redirect(url_for('main.home'))
                
    if user and role:
        link = Rolevsuser( user = user, role = role)
        db.session.add(link)
        db.session.commit()
        flash('Role has been added!', 'success')
    
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))

@managers.route("/remove_role/<int:user>/<int:role>", methods=['GET', 'POST'])
@login_required
def remove_role(user, role):
    if user == current_user.id and current_user.RSI_handle != "Cyber-Dreamer":
        return redirect(url_for('main.home'))
    
    role = Role.query.filter_by(id = role).first()
    if security_test(user = current_user.id, division = role.division_id, department = role.department_id) == False:
        return redirect(url_for('main.home'))
    
    if user and role:
        user = User.query.filter_by(id = user).first()
        Rolevsuser.query.filter_by(user = user, role = role).delete()
        
        db.session.commit()
        flash('Role has been removed!', 'success')
    
    next_page = request.args.get('next')
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))



@managers.route("/user_manager", defaults={"department": 0, "division": 0, "search": None}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>", defaults={"division": 0, "search": None}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>/<int:division>", defaults={"search": None}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>/<int:division>/<search>", methods=['GET', 'POST'])
@login_required
def user_manager(department, division, search):
    if security_test(user = current_user.id, division = division, department = department) == False:
        return redirect(url_for('main.home'))
    
    
    if search is not None:
        print(search)
        users = User.query.filter(User.RSI_handle.like('%' + search + '%')).all()
    else:
        users = User.query
        
    
    
    if department == 0 and division == 0:
        users = users.order_by(User.RSI_handle).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division)
        users = []
        for role in roles:
            print(role.members)
            for member in role.members:
                user = User.query.filter_by(id = member.user_id).first()
                if user not in users:
                    users.append(user)
            
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).all()
        users = []
        for role in roles:
            for member in role.members:
                user = User.query.filter_by(id = member.user_id).first()
                if user not in users:

                    users.append(user)
        
        #User.query.join(User.roles).filter(User.roles.any(Role.department_id == department)).options(contains_eager(User.roles)).all()
    
        
    if current_user.RSI_handle == 'Cyber-Dreamer':
        divisions = Division.query.order_by(Division.title).all()
        departments = Department.query.order_by(Department.title).all()
        roles = Role.query.order_by(Role.title).all()
    return render_template("managers/user_manager.html", title = "User manager", users = users, divisions = divisions, departments = departments, currentdiv = division, currentdep = department, roles = roles)


#================================================= Role =========================================================
@managers.route("/role_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_manager(department, division):
    if security_test(user = current_user.id, division = division, department = department) == False:
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
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles, Role = Role,  form=form, divisions = divisions, departments = departments, currentdiv = division, currentdep = department)


#================================================= Division =========================================================

@managers.route("/division_manager", defaults={"department": 0}, methods=['GET', 'POST'])
@managers.route("/division_manager/<int:department>", methods=['GET', 'POST'])
@login_required
def division_manager(department):
    if security_test(user = current_user.id, department = department) == False:
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
    
    return render_template("managers/division_manager.html", title = "Division manager", divisions = divisions,  form=form, departments = departments, currentdep = department)


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
    if security_test(user = current_user.id) == False:
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
    return render_template("managers/department_manager.html", title = "Department manager", Role = Role, departments = departments,  form=form)


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