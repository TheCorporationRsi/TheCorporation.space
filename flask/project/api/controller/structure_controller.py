from project import db
import project.models as models
from sqlalchemy import func, or_
from ..security_wraps import admin_only, manager_only


@admin_only
def add_department(title , color):
    department = models.Department.query.filter(or_(models.Department.title == title, models.Department.color == color)).first()
    
    if department:
        return 0
    else:
        department = models.Department(title = title, color = color)
        db.session.add(department)
        db.session.commit()
        return 1


@admin_only
def add_division(title , department_id, motto =None):
    division = models.Division.query.filter_by(title = title).first()
    
    if division:
        return 0
    else:
        department = models.Department.query.filter_by(id = department_id).first()
        division = models.Division(title = title, color = department.color, department = department, motto = motto)
        db.session.add(division)
        db.session.commit()
        return 1

@manager_only
def add_role(title, color):
    pass