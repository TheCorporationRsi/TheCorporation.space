from project import socketio
import datetime
import uuid
from ... import shell

import project.api.bots.handlers.discord.controller as discord_controller
import project.models as models


discord_context_tmp_history = []

def context_generator(user_id, username, server_id, channel_id, message, in_DM = False):
        ctx = None
    
        if message[0] == shell.trigger:
            ctx = discord_ctx(user_id=user_id, username=username, server_id=server_id, channel_id=channel_id, in_DM=in_DM)
        else:
            for context in discord_context_tmp_history:
                if context.updated_at > datetime.now() - datetime.timedelta(minutes=10):
                    discord_context_tmp_history.remove(context)
                elif context.user_id == user_id and ((channel_id == channel_id) or (context.in_DM and in_DM) ):
                    ctx = context
                    discord_context_tmp_history.remove(context)
        
        if not ctx:
            return -1
        
        if ctx.generate_arguments(message) == -1:
            return -1
        
        return ctx

class discord_ctx():
    type = "discord"
    default_server_id = discord_controller.default_server_id
    
    def __init__(self, user_id, server_id, channel_id, username, in_DM = False):
        self.context_id = uuid.uuid4()
        self.user_id = user_id
        self.server_id = server_id
        self.channel_id = channel_id
        self.in_DM = in_DM
        self.username = username
        
        self.arguments = []
        
        self.created_at = datetime.datetime.now()
        self.updated_at = datetime.datetime.now()
    
    def generate_arguments(self, command):
        arguments = command.split(" ")
        print(arguments)
        for argument in arguments:
            if len(argument) > 0 and argument[0] == "$":
                argument = argument.replace('$', '')
            elif len(argument) > 10 and argument[0] == '<':
                if argument[1] == '@':
                    argument = argument.replace('<@', '')
                    argument = argument.replace('>', '')
                    discord_id = argument
                    argument = None
                    argument = models.User.query.filter_by(discord_id = discord_id).first()
                    if not argument:
                        self.send(message="User not linked to the website")
                        return -1
                elif argument[1] == '#':
                    argument = argument.replace('<#', '')
                    argument = argument.replace('>', '')
                    channel_id = argument
                    argument = channel(ctx=self, channel_id=channel_id, server_id=self.server_id)
            
            self.arguments.append(argument)
    
    @property
    def user(self):
        user = models.User.query.filter_by(discord_id = self.user_id).first()
        return user if user else -1
    
    def id_to_user(self, id):
        user = models.User.query.filter_by(discord_id = id).first()
        return user
    
    def handle_to_user(self, RSI_handle):
        user = models.User.query.filter_by(RSI_handle = RSI_handle).first()
        return user
    
    def user_mention(self, user_id):
        return "<@" + user_id + ">"
    
    ''' def send_tmp_response(self, message, in_DM = False ):
        self.updated_at = datetime.datetime.now()
        self.in_DM = (in_DM or self.in_DM)
        discord_context_tmp_history += self
        self.send(message = message, in_DM= in_DM)
    
    def send_final_response(self, message, in_DM = False):
        for context in discord_context_tmp_history:
            if context.context_id == self.context_id:
                discord_context_tmp_history.remove(context)
        self.send(message = message) '''
    
    def send(self, message, channel_id= None):
        if not channel_id:
            channel_id = self.channel_id
        discord_controller.send_message(message=message, channel_id=channel_id)
    
    def dm_sender(self, message):
        discord_controller.send_dm(message=message, user_id=self.user_id)
    
    def callback(self, data):
        pass



class channel():
    
    def __init__(self, channel_id, server_id, ctx = None):
        self.channel_id = channel_id
        self.server_id = server_id
        self.ctx = ctx
        self.members_list = None
    
    def send(self, message):
        self.ctx.send(message= message, channel_id = self.channel_id)
    
    def members(self):
        
        def update_channel(data, channel = self, ctx = self.ctx):
            for argument in ctx.arguments:
                if argument == channel:
                    argument.members_list = data['user_list']
            shell.call(ctx)
        
        
        if self.members_list:
            return self.members_list
        else:
            discord_controller.get_channel_user(channel_id = self.channel_id, server_id = self.server_id, callback = update_channel)