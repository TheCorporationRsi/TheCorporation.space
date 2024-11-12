from flask_socketio import Namespace, emit
from flask import request

from corp_system import limiter, socketio
import os
import importlib
import inspect
import re

import shlex

from corp_system.controllers.influence_system_manager import InfluenceSystemManager

def get_command_functions():
    command_functions = {}
    
    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    commands_dir = os.path.join(script_dir, 'commands')
    
    # Iterate over all Python files in the commands folder
    for filename in os.listdir(commands_dir):
        if filename.endswith(".py") and filename != "__init__.py":
            module_name = filename[:-3]  # Remove the .py extension
            module = importlib.import_module(f'.commands.{module_name}', package='corp_system.bot')
            
            # Get all functions in the module
            functions = inspect.getmembers(module, inspect.isfunction)
            
            blacklist = ["generate_memorable_password"]
            
            command_functions.update({name: func for name, func in functions if not name.endswith("_only") and name not in blacklist})
    
    return command_functions


class Bot_space(Namespace):
    
    def __init__(self, *args, **kwargs):
        
        # Extract specific arguments from kwargs
        self.api_key = kwargs.pop('api_key', None)
        self.service_name = kwargs.pop('service_name', None)
        self.context_model = kwargs.pop('context_model', None)
        self.namespace_name = kwargs.pop('namespace_name', None)
        
        commands= get_command_functions()
        self.commands = commands
        
        super().__init__(*args, **kwargs)
        
    
    @limiter.limit("1 per second")
    def on_connect(self, data):
        
        api_key = data.get('api_key')
        print(api_key)
        # ensure that the client that connect to this namespace has the correct api_key
        if api_key != self.api_key:
            return False
        
    def on_disconnect(self):
        print(f'{self.service_name} bot disconnected')
        
    def on_message(self, data):
        user_id = data['user_id']
        server_id = data['server_id']
        channel = data['channel_id']
        message = data['message']
        
        in_dm = data['in_DM']
        
        command = message.split()[0][1:]
        
        arguments = shlex.split(message)[1:]
        
        try:
            context = self.context_model(user_id=user_id, channel_id=channel, arguments=arguments, in_dm=in_dm, commands=self.commands)
            
            if not re.match("^[a-zA-Z0-9_]{1,32}$", command):
                raise ValueError("Command doesn't follow format")
            
            if command not in self.commands:
                raise ValueError("Command not found")
            
            self.commands[command](ctx=context)
            
        except ValueError as e:
            emit('dm_message', {"user_id": user_id, "message": str(e)}, namespace=self.namespace_name)  
        
    
    def on_influence_emote(self, data):
        sender_id = data['sender']
        amount = data['amount']
        receiver_id = data['receiver']
        
        try:
            sender = self.context_model.load_user(sender_id)
            
            if not sender:
                raise ValueError(f"Sender not linked to {self.service_name}")
            
            receiver = self.context_model.load_user(receiver_id)
            
            if not receiver:
                raise ValueError(f"Receiver not linked to {self.service_name}")
            
            
            InfluenceSystemManager.send_tribute(sender=sender, receiver=receiver, amount=amount, method=f"{self.service_name}_emote")
            
            emit('dm_message', {"user_id": sender_id, "message": f"You sent {amount} tribute to {receiver.RSI_handle}"}, namespace=self.namespace_name)
            emit('dm_message', {"user_id": receiver_id, "message": f"You received {amount} tribute from {sender.RSI_handle}"}, namespace=self.namespace_name)
            
        except ValueError as e:
            emit('dm_message', {"user_id": sender_id, "message": str(e)}, namespace=self.namespace_name)
    
    def on_role_added(self, data):
        role_id = data['role_id']
        user_id = data['user_id']
        
        try:
            user = self.context_model.load_user(user_id)
            
            if not user:
                raise ValueError(f"You {self.service_name} account is not linked to the website, your roles won't be synced")
            
            role = self.context_model.load_role(role_id)
            
            if role:
                user.add_role(role)
            
            
        except ValueError as e:
            emit('dm_message', {"user_id": user_id, "message": str(e)}, namespace=self.namespace_name)
            
    def on_role_removed(self, data):
        role_id = data['role_id']
        user_id = data['user_id']
        
        try:
            user = self.context_model.load_user(user_id)
            
            if not user:
                raise ValueError(f"You {self.service_name} account is not linked to the website, your roles won't be synced")
            
            role = self.context_model.load_role(role_id)
            
            if role:
                user.remove_role(role)
            
        except ValueError as e:
            emit('dm_message', {"user_id": user_id, "message": str(e)}, namespace=self.namespace_name)
        
        
        
    
        


    

    