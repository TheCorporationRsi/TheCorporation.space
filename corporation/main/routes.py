from flask import render_template, request, Blueprint
from corporation.models import Post

from flask import Blueprint

main = Blueprint('main', __name__)


@main.route("/")
@main.route("/home")
def home():
    return render_template("home.html")


@main.route("/about")
def about():
    return render_template("about.html", title = "About")


@main.route("/calendar")
def calendar():
    return render_template("calendar.html", title = "Calendar")