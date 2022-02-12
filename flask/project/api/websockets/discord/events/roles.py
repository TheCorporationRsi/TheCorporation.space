from flask_socketio import emit, join_room, leave_room, ConnectionRefusedError, disconnect
from flask import request
from project import socketio
from project.models import User, Role



@socketio.on('role_removed', namespace='/discord_bot')
def influence_emote(data):
    user_id = data['user']
    role_id = data['role_id']

    user = User.query.filter_by(discord_id = user_id).first()
    role = Role.query.filter_by(discord_id = role_id).first()
    
    if role and user:
        user.remove_role(role, "from_discord")

@socketio.on('role_added', namespace='/discord_bot')
def influence_emote(data):
    user_id = data['user']
    role_id = data['role_id']

    user = User.query.filter_by(discord_id = user_id).first()
    role = Role.query.filter_by(discord_id = role_id).first()
    
    if role and user:
        user.add_role(role, "from_discord")