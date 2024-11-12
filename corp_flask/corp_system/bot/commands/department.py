from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User, Department
from corp_system import db

from corp_system.controllers.structure_manager import StructureManager

from corp_system.tools.random_password import generate_memorable_password


def departments(ctx):
    '''!departments'''
    departments = Department.query.all()
    
    message = "Departments:\n"
    for department in departments:
        message += f" - {department.title}\n"
    
    ctx.send(message)

@admin_only
def create_department(ctx):
    '''!create_department <title>'''
    title = ctx.get_argument(0, "string").value
    StructureManager.create_department(title)
    
    ctx.send("Department created")