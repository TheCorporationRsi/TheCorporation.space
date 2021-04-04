from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, User_Role, Departement
from flask_discord import requires_authorization
from corporation.managers.forms import CreationForm

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

@managers.route("/role_manager", methods=['GET', 'POST'])
@login_required
def role_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    roles = Role.query.order_by(Role.division_id.desc())
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles)


@managers.route("/division_manager", methods=['GET', 'POST'])
@login_required
def division_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    
    form = CreationForm()
    if form.validate_on_submit():
        division = Division(title= form.title.data, created_by= current_user.id)
        db.session.add(division)
        db.session.commit()
        flash('Your post has been created!', 'success')
    
    divisions = Division.query.order_by(Division.title).all()
    print(divisions)
    return render_template("managers/division_manager.html", title = "Division manager", divisions = divisions,  form=form, User_Role = User_Role)


@managers.route("/division_manager/<int:divison_id>/delete", methods=['POST'])
@login_required
def delete_post(division_id):
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    division = Division.query.get_or_404(division_id)
    db.session.delete(division)
    db.session.commit()
    flash('Division has been deleted!', 'success')
    return redirect(url_for('managers.division_manager'))
    
@managers.route("/erkul")
def erkul():
    return render_template("tool/erkul.html", title = "Erkul.games")