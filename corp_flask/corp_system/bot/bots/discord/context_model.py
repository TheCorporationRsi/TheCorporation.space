from corp_system.models import User, Role
from flask_socketio import emit

from corp_system import db

import re


class Argument():
    
    def __init__(self, argument, type):
        self.type = type
        
        if self.type == "member":
            if argument.startswith("<@") and argument.endswith(">"):
                self.value = User.query.filter_by(discord_id=str(argument[2:-1])).first()
            else:
                self.value = User.query.filter_by(RSI_handle=argument).first()
            
            if not self.value:
                raise ValueError("User not linked to discord")
        elif self.type == "role":
            if argument.startswith("<@&") and argument.endswith(">"):
                self.value = Role.query.filter_by(discord_id=str(argument[3:-1])).first()
            else:
                self.value = Role.query.filter_by(title=argument).first()
                
            if not self.value:
                raise ValueError("Role not found")
            
        elif self.type == "channel":
            self.value = argument
        elif self.type == "string":
            self.value = argument
        elif self.type == "id_only":
            self.value = re.sub(r'\D', '', argument)
    
    def send(self, message):
        if self.type != "channel":
            raise ValueError("Argument is not a channel")
        
        emit('send_message', {"channel_id": self.value, "message": message}, namespace='/discord_bot')
        
        

class Context:
    
    _arguments = []
    
    def __init__(self, user_id, channel_id, arguments=None, in_dm=False, commands=None):
        
        self.user_id = user_id
        
        self.commands = commands
        
        self.current_user = User.query.filter_by(discord_id=str(user_id)).first()
        if not self.current_user:
            self.authenticated = False
        else:
            self.authenticated = True
            
        self.channel_id = channel_id
        self.in_dm = in_dm
        
        self._arguments = arguments
        
    def get_argument(self, number, type):
        if len(self._arguments) <= number:
            raise ValueError("Argument missing")
        argument = self._arguments[number]
        return Argument(argument, type)

    def send(self, message, in_dm=False):
        if self.in_dm or in_dm:
            emit('dm_message', {"user_id": self.user_id, "message": message}, namespace='/discord_bot')
        else:
            emit('send_message', {"channel_id": self.channel_id, "message": message}, namespace='/discord_bot')
    
    def link_user(self, user):
        user.discord_id = self.user_id
        db.session.commit()
        
        emit('change_nickname', {"member_id": self.user_id, "nickname": user.RSI_handle}, namespace='/discord_bot')
        
        self.send('You have been linked to this discord account', in_dm=True)
    
    @staticmethod
    def load_user(user_id):
        user = User.query.filter_by(discord_id=str(user_id)).first()
        return user
    
    @staticmethod
    def load_role(role_id):
        user = Role.query.filter_by(discord_id=str(role_id)).first()
        return user
    
    def get_role_id(self, role):
        return "<@&"+ role.discord_id +">" if role.discord_id else None
    
    def link_role(self, role, role_id):
        role.discord_id = str(role_id)
        db.session.commit()
        
    def update_profile(self, user):
        user.update_profile()
    
    @staticmethod
    def upload_roles(user_id):
        emit('upload_roles', {'user': user_id}, namespace='/discord_bot')



       