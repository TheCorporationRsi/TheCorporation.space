from project import socketio
from datetime import datetime
import uuid

import project.api.bots.shell as shell

import project.api.bots.controller as bot_controller
import project.models as models

import project.api.bots.handlers.discord.controller as discord_controller

@socketio.on('role_removed', namespace='/discord_bot')
def discord_influence_added(data):
    user_id = data['user']
    role_id = data['role_id']

    user = models.User.query.filter_by(discord_id = user_id).first()
    role = models.Role.query.filter_by(discord_id = role_id).first()
    
    if role and user:
        user.remove_role(role, "from_discord")


@socketio.on('role_added', namespace='/discord_bot')
def discord_role_added(data):
    user_id = data['user']
    role_id = data['role_id']

    user = models.User.query.filter_by(discord_id = user_id).first()
    role = models.Role.query.filter_by(discord_id = role_id).first()
    
    if role and user:
        user.add_role(role, "from_discord")

@socketio.on('discord_shell_call', namespace='/discord_bot')
def discord_shell_call(data):
    user_id = data['user_id']
    server_id = data['server_id']
    channel_id = data['channel_id']
    message = data['message']
    in_DM = data['in_DM']
    username = data['username']
    print(message)
    
    discord_controller.handle_message(user_id=user_id, username=username, server_id=server_id, channel_id=channel_id, message=message, in_DM=in_DM)

@socketio.on('discord_influence_emote', namespace='/discord_bot')
def discord_influence_emote(data):
    sender_id = data['sender_id']
    receiver_id = data['receiver_id']
    message_id = data['message_id']
    amount = data['amount']
    
    bot_controller.send_tribute(controller = discord_controller, sender_id=sender_id, receiver_id=receiver_id, message_id=message_id, amount=amount)
