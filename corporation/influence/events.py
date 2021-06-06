from flask_socketio import emit, join_room, leave_room, ConnectionRefusedError, disconnect
from flask import request
from corporation import socketio
from corporation.models import User


""" @socketio.on('influence_emote', namespace='/discord_bot')
def joined(message):
    room = session.get('room')
    join_room(room)
    emit('status', {'msg': session.get('name') + ' has entered the room.'}, room=room) """
    
@socketio.on('connect', namespace='/discord_bot')
def welcome_bot(sid):
    print("Discord bot is connected")


@socketio.on('influence_emote', namespace='/discord_bot')
def influence_emote(data):
    sender_id = data['sender']
    amount = data['amount']
    receiver_id = data['receiver']
    message_id = data['message_id']
    print("Influence transfer:")

    print('From: '+ str(sender_id))
    print('Amount: '+ str(amount))
    print('To: '+ str(receiver))
    
    sender = User.query.filter_by(discord_id = str(sender_id)).first()
    receiver = User.query.filter_by(discord_id = str(receiver_id)).first()
    if not sender:
        print('Sender not registered!')
        socketio.emit('infuence_error', {
            'sender': sender_id,
            'amount': 1,
            'receiver': receiver_id,
            'message_id': message_id
            
            }, namespace='/discord_bot')
        
    elif not receiver:
        print('Receiver not registered!')
        socketio.emit('inlfuence_error', {
            'sender': sender_id,
            'amount': 1,
            'receiver': receiver_id,
            'message_id': message_id
            
            }, namespace='/discord_bot')
    elif receiver and sender and amount > 0:
        sender.send_tribute( receiver, amount, message= "Sent by emote")