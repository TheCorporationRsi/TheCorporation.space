import datetime
from project import socketio
import uuid
import project.api.bots.shell as shell
import project.api.bots.handlers.discord.context as discord_context
import project.models as models

default_server_id = 831248117571649566

def user_to_id(user):
    return user.discord_id if user.discord_id else -1

def id_to_user(user_id):
    user = models.User.query.filter_by(discord_id=user_id).first()
    return user if user else -1

def add_role(user, role):
    user_id = user.discord_id
    role_id = role.discord_id
    if user_id:
        socketio.emit('add_role', {
            'user': user_id,
            'role_id': role_id
        }, namespace='/discord_bot')

def remove_role(user, role):
    user_id = user.discord_id
    role_id = role.discord_id
    if user_id:
        socketio.emit('remove_role', {
            'user': user_id,
            'role_id': role_id
        }, namespace='/discord_bot')

def sync_role():
    pass

def get_channel_user(callback, channel_id=None, server_id=None, user_id=None):
    socketio.emit('voice_member_list', {
        'member_id': user_id,
        'server_id': server_id if server_id else default_server_id,
        'channel_id': channel_id,
        }, namespace='/discord_bot', callback=callback)
    
    
def change_nickname(user, nickname):
    user_id = user.discord_id
    if user_id:
        socketio.emit('change_nickname', {
            'member_id': user_id,
            'nickname': nickname
        }, namespace='/discord_bot')

def send_message(message, channel_id):
    socketio.emit('discord_send_message', {
        'channel_id': channel_id if channel_id else self.channel_id,
        'message': message
    }, namespace='/discord_bot')

def send_dm(message, user = None, user_id = None):
    if user:
        user_id = user.discord_id
    if user_id:    
        socketio.emit('discord_dm_message', {
            'user_id': user_id,
            'message': message
        }, namespace='/discord_bot')

def handle_message(user_id, username, server_id, channel_id, message, in_DM = False):
    ctx = discord_context.context_generator(user_id=user_id, server_id=server_id, channel_id=channel_id, username=username, in_DM=in_DM, message=message)
    if ctx and ctx != -1:
        shell.call(ctx=ctx)