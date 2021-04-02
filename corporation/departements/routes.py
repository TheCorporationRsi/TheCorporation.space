from flask import render_template, request, Blueprint
from corporation.models import Post

from flask import Blueprint

departements = Blueprint('departements', __name__)




@departements.route("/departement/info")
def dep_info():
    return render_template("departements/info.html", title = "Info")
