from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser, Webpage_template
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form, Department_webpage_form
from corporation.managers.utils import save_background, save_logo
from corporation.managers import managers



@managers.route("/add_role/<string:user_handle>/<int:role>", methods=['GET', 'POST'])
@login_required
def add_role(user_handle, role, admin = 0):
    role = Role.query.filter_by(id = role).first()

    if not current_user.is_manager():
        return redirect(url_for('main.home'))
    
    next_page = request.args.get('next')
    user = User.query.filter_by(RSI_handle = user_handle).first()
    
    if user and role:
        user.add_role(role)
        flash(role.title +' has been added to '+ user.RSI_handle+'!', 'success')
    
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))

@managers.route("/remove_role/<string:user>/<int:role>", methods=['GET', 'POST'])
@login_required
def remove_role(user, role):
    if not current_user.is_manager():
        return redirect(url_for('main.home'))
    
    role = Role.query.filter_by(id = role).first()
    user = User.query.filter_by(RSI_handle = user).first()
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
    
    
    user.remove_role(role)
    flash('Role has been removed!', 'success')
    
    next_page = request.args.get('next')
    return redirect(next_page) if next_page else redirect(url_for('managers.user_manager'))



@managers.route("/user_manager", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/user_manager/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def user_manager(department, division):
    if not current_user.is_manager('admin'):
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
        division_item = Division.query.filter_by(id = division).first()
        users = division_item.members()
            
    elif department > 0:
        department_item = Division.query.filter_by(id = department).first()
        users = department_item.members()
    
    return render_template("managers/user_manager.html", title = "User manager", users = users, currentdiv = division, currentdep = department, form = form)


@managers.route("/managers/admin/members/<string:user_handle>", methods=['GET', 'POST'])
@login_required
def user_item(user_handle):
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    user = User.query.filter_by(RSI_handle=user_handle).first()
    
    
    return render_template("managers/modules/user_template.html", user = user)