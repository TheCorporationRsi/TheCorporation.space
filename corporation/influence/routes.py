from flask import render_template, request, Blueprint
from corporation.models import Post
from corporation.influence.forms import MyForm

influence = Blueprint('influence', __name__)


@influence.route("/influence")
def influence_control():
    form = MyForm()
    return render_template("influence/influence.html", title = "Influence", form=form)

