from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User
from flask_discord import requires_authorization

from flask import Blueprint

managers = Blueprint('managers', __name__)


@managers.route("/user_manager")
@login_required
def user_manager():
    if current_user.RSI_handle != 'Cyber-Dreamer':
        return redirect(url_for('main.home'))
    
    page = request.args.get('page', 1, type=int)
    users = User.query.order_by(User.id.desc()).paginate(page= page, per_page=100)
    
    return render_template("managers/user_manager.html", title = "User manager", users = users)
    
@managers.route("/erkul")
def erkul():
    return render_template("tool/erkul.html", title = "Erkul.games")