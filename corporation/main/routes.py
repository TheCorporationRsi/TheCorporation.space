from flask import render_template, request, Blueprint, redirect
from corporation.models import Post, Division, Department, Role, Webpage_template

from flask import Blueprint

main = Blueprint('main', __name__)


@main.route("/")
@main.route("/home")
async def home():
    return render_template("landing_page.html")


@main.route("/discord")
async def discord_link():
    return redirect("https://discord.gg/ApEe8VK")

@main.route("/department/<int:id>")
def department(id=1):
    print(id)
    department = Department.query.filter_by(id=id).first()
    return render_template("department.html", title= department.title, department = department)




@main.app_context_processor
def structure_info():
    roles = Role.query.order_by(Role.department_id, Role.division_id, Role.title).all()
    divisions = Division.query.order_by(Division.department_id, Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    return dict(division_list=divisions, department_list=departments, role_list = roles)

@main.context_processor
def dep_style_info():
    templates = Webpage_template.query.all()
    return dict(tempates_info = templates)