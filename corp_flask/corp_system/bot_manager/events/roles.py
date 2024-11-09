from corp_system import socketio



@socketio.on('role_added', namespace='/discord_bot')
def role_added(data):
    
    pass