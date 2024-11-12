from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User, Division, Department, Role
from corp_system import db

from corp_system.controllers.structure_manager import StructureManager

from corp_system.tools.random_password import generate_memorable_password


@CORP_only
def update_profile(ctx):
    '''!update_profile <user>'''
    user = ctx.get_argument(0, "member").value
    
    user.update()
        
    ctx.send(f"Profile of {user.RSI_handle} updated")