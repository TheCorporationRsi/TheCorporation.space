from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, User_Role, Departement
from flask_discord import requires_authorization
from corporation.managers.forms import Departement_Form, Division_Form, Role_Form

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
@managers.route("/role_manager", defaults={"departement": 0, "division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:departement>", defaults={"division": 0}, methods=['GET', 'POST'])
@managers.route("/role_manager/<int:departement>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_manager(departement, division):
    
    print(division)
    print(departement)
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    form = Role_Form()
    if form.validate_on_submit():
        departement_id = Division.query.filter_by(id = form.division.data.id).first().id
        role = Role(title= form.title.data, division_id= form.division.data.id, departement_id= departement_id ,created_by= current_user.id)
        db.session.add(role)
        db.session.commit()
        flash('Role has been created!', 'success')
        return redirect(url_for('managers.role_manager'))
    
    if departement == 0 and division == 0:
        roles = Role.query.order_by(Role.departement_id).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division).all()
    elif departement > 0:
        roles = Role.query.filter_by(departement_id = departement).all()
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles,  form=form, User_Role = User_Role)


#================================================= Division =========================================================

@managers.route("/division_manager", defaults={"departement": 0}, methods=['GET', 'POST'])
@managers.route("/division_manager/<int:departement>", methods=['GET', 'POST'])
@login_required
def division_manager(departement = 0):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    form = Division_Form()
    if form.validate_on_submit():
        division = Division(title= form.title.data, departement_id= form.departement.data.id ,created_by= current_user.id)
        db.session.add(division)
        db.session.commit()
        flash('Division has been created!', 'success')
        return redirect(url_for('managers.division_manager'))
    
    divisions = Division.query.order_by(Division.departement_id).all()
    return render_template("managers/division_manager.html", title = "Division manager", divisions = divisions,  form=form, User_Role = User_Role)


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

#================================================= Departement =========================================================


@managers.route("/departement_manager", methods=['GET', 'POST'])
@login_required
def departement_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    
    form = Departement_Form()
    if form.validate_on_submit():
        departement = Departement(title= form.title.data, created_by= current_user.id)
        db.session.add(departement)
        db.session.commit()
        flash('Your post has been created!', 'success')
        return redirect(url_for('managers.departement_manager'))
    
    departements = Departement.query.order_by(Departement.title).all()
    return render_template("managers/departement_manager.html", title = "Departement manager", departements = departements,  form=form, User_Role = User_Role)


""" 
@managers.route("/departement_manager/<int:departement_id>/delete", methods=['GET', 'POST'])
@login_required
def delete_departement(departement_id):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    departement = Departement.query.get_or_404(departement_id)
    db.session.delete(departement)
    db.session.commit()
    flash('Departement has been deleted!', 'success')
    return redirect(url_for('managers.departement_manager'))

"""

#================================================= Other =========================================================

@managers.route("/erkul")
def erkul():
    return render_template("tool/erkul.html", title = "Erkul.games")