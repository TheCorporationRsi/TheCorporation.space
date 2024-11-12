from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User, Division, Department
from corp_system import db

from corp_system.controllers.structure_manager import StructureManager

from corp_system.tools.random_password import generate_memorable_password

import inspect

def help(ctx):
    '''!help'''
    
    message = "Commands:\n"
    for key in sorted(ctx.commands):
        func = ctx.commands[key]
        message += f"{inspect.getdoc(func)}\n"
    
    ctx.send(message)