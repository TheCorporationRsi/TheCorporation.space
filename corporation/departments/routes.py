from flask import render_template, request, Blueprint
from corporation.models import Post

from flask import Blueprint

departments = Blueprint('departments', __name__)




@departments.route("/department/info")
def dep_info():
    return render_template("departments/info.html", title = "Info")
