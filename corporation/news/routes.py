from flask import render_template, request, Blueprint
from corporation.models import Post

from flask import Blueprint

news = Blueprint('news', __name__)


@news.route("/news")
def corpnews():
    return render_template("about.html", title = "About")
    