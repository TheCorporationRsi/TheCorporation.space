from flask import render_template, request, Blueprint, redirect, jsonify
from project.models import Division, Department, Role, User
from project.sections.security.utils import send_confirmation_email

from project.sections.dashboard.pages.stats.tasks import get_funding_stats

import json
import datetime
from project.models import Funding
from project import db, scheduler

from flask import Blueprint

main = Blueprint('main', __name__)


@main.route("/")
@main.route("/home")
def home():
    return render_template("landing_page.html")


@main.route("/update_funding")
def test_some_shit_up():
    get_funding_stats()
    return jsonify("lol")


@main.route("/discord")
def discord_link():
    return redirect("https://discord.gg/ApEe8VK")


@main.route("/department/<string:title>")
def department(title="Exploration"):
    department = Department.query.filter_by(title=title).first()
    return render_template("department.html", title=department.title, department=department)


@main.app_context_processor
def structure_info():
    roles = Role.query.order_by(Role.department_id, Role.division_id, Role.title).all()
    divisions = Division.query.order_by(Division.department_id, Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    return dict(division_list=divisions, department_list=departments, role_list=roles)

""" 
@main.context_processor
def dep_style_info():
    templates = Webpage_template.query.all()
    return dict(tempates_info=templates)
 """