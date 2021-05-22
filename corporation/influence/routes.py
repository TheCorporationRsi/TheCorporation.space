from flask import render_template, request, Blueprint, flash, url_for, redirect
from corporation.models import Post, User
from corporation.influence.forms import MyForm
from flask_login import current_user, login_required
from corporation import db, scheduler

influence = Blueprint('influence', __name__)


@influence.route("/influence", methods=['GET', 'POST'])
@login_required
def influence_send():

    form = MyForm()
    if form.validate_on_submit():

        flash(f'Transfer sucessful!', 'success')

    return render_template("influence/influence.html", title="Influence", form=form)
