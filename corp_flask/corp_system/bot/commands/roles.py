from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User, Division, Department, Role
from corp_system import db

from corp_system.controllers.structure_manager import StructureManager

from corp_system.tools.random_password import generate_memorable_password


def roles(ctx):
    '''!roles'''
   
    roles = Role.query.all()
    
    message = "Roles:\n"
    for role in roles:
        message += f" - {role.title}\n"
        
    ctx.send(message)

@CORP_only
def my_roles(ctx):
    '''!myroles'''
    roles = ctx.current_user.roles
    
    message = "Roles:\n"
    for role in roles:
        message += f" - {role.title}\n"
    
    ctx.send(message)
    
@CORP_only
def upload_roles(ctx):
    '''!upload_roles'''
    ctx.upload_roles(ctx.user_id)
    
    ctx.send("Role uploading")

@admin_only
def remove_role(ctx):
    '''!remove_role <role> <user>'''
    role = ctx.get_argument(0, "role").value
    user = ctx.get_argument(1, "member").value
    
    user.remove_role(role)
    
    ctx.send("Role removed")
    
@admin_only
def add_role(ctx):
    '''!add_role <role> <user>'''
    role = ctx.get_argument(0, "role").value
    user = ctx.get_argument(1, "member").value
    
    user.add_role(role)
    
    ctx.send("Role added")
    
    
@admin_only
def link_role(ctx):
    '''!link_role <role_title> <service_role>'''
    role = ctx.get_argument(0, "role").value
    
    role_id = ctx.get_argument(1, "id_only").value
    
    ctx.link_role(role=role, role_id=role_id)
    
    ctx.send("Role linked")
    
@admin_only
def roles_links(ctx):
    '''!roles_links'''
   
    roles = Role.query.all()
    
    message = "Roles:\n"
    for role in roles:
        message += f" - {role.title} : {ctx.get_role_id(role) if ctx.get_role_id(role) is not None else "Not linked"}\n"
        
    ctx.send(message)