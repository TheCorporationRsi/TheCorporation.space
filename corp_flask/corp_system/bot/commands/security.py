from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only, DM_only

from corp_system.models import User
from corp_system import db

from corp_system.controllers.security_manager import SecurityManager

from corp_system.tools.random_password import generate_memorable_password

from sqlalchemy import func

@DM_only
def login(ctx):
    '''!login <username> <password> #in DM only'''
    username = ctx.get_argument(0, "string").value
    password = ctx.get_argument(1, "string").value
    
    user: User = User.query.filter_by(RSI_handle=username).first()
    if not user:
        raise ValueError("User not found")
    
    if not user.check_password(password):
        raise ValueError("Password incorrect")
    
    ctx.link_user(user)
    
    if user.CORP_confirmed:
        ctx.upload_roles(ctx.user_id)
        user.update()


def register(ctx):
    '''!register <username>'''
    
    username = ctx.get_argument(0, "string").value
    password = generate_memorable_password()
    SecurityManager.register_user(RSI_handle=username, password=password)
    
    ctx.send(f"{username} has been registered, please look in your DMs for your password")
    ctx.send(f"Your website password is: {password}", in_dm=True)
    
    user = User.query.filter(func.lower(User.RSI_handle) == func.lower(username)).first()
    ctx.link_user(user)
    

def rsi_token(ctx):
    '''!rsi_token <username>'''
    username = ctx.get_argument(0, "string").value
    
    token = SecurityManager.rsi_token(RSI_handle=username)
    ctx.send(f"{username} RSI token is:\n\n {token} \n\nPlease insert it into your RSI profile biography")


def verify(ctx):
    '''!verify <username>'''
    username = ctx.get_argument(0, "string").value
    SecurityManager.verify_rsi_token(RSI_handle=username)
    
    ctx.send(f"{username} has been verified!")


