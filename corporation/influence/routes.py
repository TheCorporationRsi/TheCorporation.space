from flask import render_template, request, Blueprint
from corporation.models import Post

from flask import Blueprint

influence = Blueprint('influence', __name__)


@influence.route("/influence")
def influence_control():
    return render_template("about.html", title = "About")

