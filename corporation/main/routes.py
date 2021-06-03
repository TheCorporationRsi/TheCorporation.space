from flask import render_template, request, Blueprint
from corporation.models import Post, Division, Department, Role

from flask import Blueprint

main = Blueprint('main', __name__)


@main.route("/")
@main.route("/home")
def home():
    return render_template("landing_page.html")

@main.route("/department/<int:id>")
def department(id=1):
    print(id)
    department = Department.query.filter_by(id=id).first()
    return render_template("department.html", title= department.title, department = department)


@main.route("/about")
def about():
    return render_template("about.html", title = "About")


@main.route("/calendar")
def calendar():
    return render_template("calendar.html", title = "Calendar")


@main.app_context_processor
def structure_info():
    roles = Role.query.order_by(Role.division_id, Role.department_id, Role.title).all()
    divisions = Division.query.order_by(Division.department_id, Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    return dict(division_list=divisions, department_list=departments, role_list = roles)