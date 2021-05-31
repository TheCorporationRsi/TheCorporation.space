from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form

managers = Blueprint('managers', __name__)
    

@managers.route("/add_role/<int:user>/<int:role>", methods=['GET', 'POST'])
@login_required
def add_role(user, role, admin = 0):
    if not current_user.is_manager():
        return redirect(url_for('main.home'))
    
    next_page = request.args.get('next')
    role = Role.query.filter_by(id = role).first()
    user = User.query.filter_by(id = user).first()
    
    if role.dep_head and not current_user.is_manager("admin"):
        flash('You dont have the proper permission!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    elif role.div_head and not current_user.is_manager(department = role.department_id):
        flash('You dont have the proper permission!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    elif not current_user.is_manager():
        flash('You dont have the proper permission!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    if user.has_role(role):
        flash('User allready have the role!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
            
                
    if user and role:
        user.add_role(role)
        flash(role.title +' has been added to '+ user.RSI_handle+'!', 'success')
    
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))

@managers.route("/remove_role/<int:user>/<int:role>", methods=['GET', 'POST'])
@login_required
def remove_role(user, role):
    if not current_user.is_manager():
        return redirect(url_for('main.home'))
    
    role = Role.query.filter_by(id = role).first()
    user = User.query.filter_by(id = user).first()
    next_page = request.args.get('next')
    
    if role.dep_head and not current_user.is_manager("admin"):
        flash('You dont have the proper permission!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    elif role.div_head and not current_user.is_manager(department = role.department_id):
        flash('You dont have the proper permission!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    if not user.has_role(role):
        flash('User dont have the role!', 'danger')
        return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))
    
    
    Rolevsuser.query.filter_by(RSI_handle = user.RSI_handle, role_id = role.id).delete()
    db.session.commit()
    flash('Role has been removed!', 'success')
    
    next_page = request.args.get('next')
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))



@managers.route("/user_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def user_manager(department, division):
    if division > 0:
        if not current_user.is_manager(division = division):
            return redirect(url_for('main.home'))
    else:
        if not current_user.is_manager(department = department, division = division):
            return redirect(url_for('main.home'))
    
    
    form = Search_Form()
    if form.validate_on_submit():
        print(form.RSI_handle.data)
        users = User.query.filter(User.RSI_handle.like('%' + form.RSI_handle.data + '%'))
        
    else:
        users = User.query
        
    
    
    if department == 0 and division == 0:
        users = users.order_by(User.RSI_handle).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division)
        users = []
        for role in roles:
            links = Rolevsuser.query.filter_by(role_id = role.id).all()
            for link in links:
                user = User.query.filter_by(RSI_handle = link.RSI_handle).first()
                if user not in users:
                    users.append(user)
            
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).all()
        users = []
        for role in roles:
            links = Rolevsuser.query.filter_by(role_id = role.id).all()
            for link in links:
                user = User.query.filter_by(RSI_handle = link.RSI_handle).first()
                if user not in users:
                    users.append(user)
        
        #User.query.join(User.roles).filter(User.roles.any(Role.department_id == department)).options(contains_eager(User.roles)).all()
    
    
    divisions = Division.query.order_by(Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    roles = Role.query.order_by(Role.title).all()
    return render_template("managers/user_manager.html", title = "User manager", users = users, divisions = divisions, departments = departments, currentdiv = division, currentdep = department, roles = roles, form = form)


#================================================= Role =========================================================
@managers.route("/role_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_manager(department, division):
    if division > 0:
        if not current_user.is_manager(division = division):
            return redirect(url_for('main.home'))
    else:
        if not current_user.is_manager(department = department, division = division):
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
        
    
    divisions = Division.query.order_by(Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles, Role = Role,  form=form, divisions = divisions, departments = departments, currentdiv = division, currentdep = department, update_form=update_form, update_color_form=update_color_form)


#================================================= Division =========================================================

@managers.route("/division_manager", defaults={"department": 0}, methods=['GET', 'POST'])
@managers.route("/division_manager/<int:department>", methods=['GET', 'POST'])
@login_required
def division_manager(department):
    if not current_user.is_manager(department = department):
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
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    
    form = Department_Form(prefix="new")
    if form.submit.data and form.validate_on_submit():
        
        department = Department(title= form.title.data, created_by= current_user.RSI_handle)
        db.session.add(department)
        db.session.commit()
        
        department_id = department.id
        dp_head = Role(title= form.title.data + " Head", dep_head = True , created_by = current_user.RSI_handle , department_id = department_id )
        dp_proxy = Role(title= form.title.data + " Proxy", dep_proxy = True, created_by = current_user.RSI_handle , department_id = department_id )
        db.session.add(dp_head)
        db.session.add(dp_proxy)
        db.session.commit()
        flash('The Department has been created!', 'success')
        return redirect(url_for('managers.department_manager'))
    
    update_form = Dep_Form(prefix="update")
    if update_form.update.data and update_form.validate_on_submit():
        department = Department.query.filter_by(id = update_form.department_id.data).first()
        department.title = update_form.title.data
        department.color = update_form.color.data
        
        head = Role.query.filter_by(department_id = department.id, dep_head= True).first()
        proxy = Role.query.filter_by(department_id = department.id, dep_proxy= True).first()
        
        head.title = department.title +" Head"
        proxy.title = department.title +" Proxy"
        
        db.session.commit()
        flash('The Department has been updated!', 'success')
    
    departments = Department.query.order_by(Department.title).all()
    return render_template("managers/department_manager.html", title = "Department manager", Role = Role, departments = departments,  form=form, update_form=update_form)


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

""" def security_test(user = 0, handle = None, division = 0, department = 0):
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
    
    return False """

#================================================= Other =========================================================

@managers.route("/erkul")
def erkul():
    return render_template("tool/erkul.html", title = "Erkul.games")