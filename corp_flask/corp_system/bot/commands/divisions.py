from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User, Division, Department
from corp_system import db

from corp_system.controllers.structure_manager import StructureManager

from corp_system.tools.random_password import generate_memorable_password


def divisions(ctx):
    '''!divisions'''
   
    departments = Department.query.all()
    
    message = "Divisions:\n"
    for department in departments:
        message += f" - {department.title}\n"
        for division in department.divisions:
            message += f"   - {division.title}\n"
    
    ctx.send(message)

@admin_only
def create_division(ctx):
    '''!create_division <title> <department>'''
    title = ctx.get_argument(0, "string").value
    department = ctx.get_argument(1, "string").value
    StructureManager.create_division(title=title, department_title=department)
    
    ctx.send("Division created")