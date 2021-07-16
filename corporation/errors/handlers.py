from flask import Blueprint, render_template, redirect, url_for
from flask_discord import Unauthorized

errors = Blueprint('errors', __name__)

@errors.app_errorhandler(404)
def error404(error):
    return render_template('errors/404.html', title= "Error"), 404

@errors.app_errorhandler(403)
def error403(error):
    return render_template('errors/403.html', title= "Error"), 403

@errors.app_errorhandler(500)
def error500(error):
    return render_template('errors/500.html', title= "Error"), 500

@errors.app_errorhandler(Unauthorized)
def redirect_unauthorized(e):
    return redirect(url_for("login"))