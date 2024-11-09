from corp_system import socketio

from flask import request

import os

@socketio.on('connect', namespace='/discord_bot')
def handle_connect():
    token = request.args.get('token')
    remote_addr = request.remote_addr
    
    if token == os.environ.get('DISCORD_API_KEY') and remote_addr == '127.0.0.1':
        return True
    
    return False  # Refuse connection