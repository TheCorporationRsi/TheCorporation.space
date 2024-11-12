
from flask_socketio import emit

from corp_system.models import Role, User




class discord_controller():
    
    def __init__(self):
        pass
    
    def add_role(user: User, role: Role):
        if user.discord_id and role.discord_id:
            emit('add_role', {"user": user.discord_id, "role_id": role.discord_id}, namespace='/discord_bot')
    
    def remove_role(user: User, role: Role):
        if user.discord_id and role.discord_id:
            emit('remove_role', {"user": user.discord_id, "role_id": role.discord_id}, namespace='/discord_bot')
    
    def sync_role(user: User):
        
        roles = Role.query.filter(Role.discord_id.isnot(None)).all()
        for role in roles:
            if role in user.roles:
                discord_controller.add_role(user, role)
            else:
                discord_controller.remove_role(user, role)
                
    def update_nickname(user: User):
        if user.discord_id:
            emit('change_nickname', {"member_id": user.discord_id, "nickname": user.RSI_handle}, namespace='/discord_bot')
    
    def send_message(channel_id, message):
        emit('send_message', {"channel_id": channel_id, "message": message}, namespace='/discord_bot')
    
    def send_dm(user: User, message):
        user_id = user.discord_id
        if user_id:
            emit('dm_message', {"user_id": user_id, "message": message}, namespace='/discord_bot')