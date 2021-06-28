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
    print('To: '+ str(receiver_id))
    
    sender = User.query.filter_by(discord_id = str(sender_id)).first()
    receiver = User.query.filter_by(discord_id = str(receiver_id)).first()
    if not sender:
        print('Sender not registered!')
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Unable to find your corporation account. Please make sure you are linked on the website"
            
            }, namespace='/discord_bot')
        
    elif not receiver:
        print('Receiver not registered!')
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Unable to find this member corporation account. Please make sure he link his account on the website"
            
            }, namespace='/discord_bot')
    elif receiver is sender:
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "You cannot send tribute to yourself!"
            
            }, namespace='/discord_bot')
    elif amount > 0 and sender.tribute().amount  >= amount:
        status = sender.send_tribute( receiver, amount, message= "Sent by emote")
        if status == 0:
            socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Transfer sucessful of "+ str(amount) +" tribute to "+ receiver.RSI_handle +"!"
            
            }, namespace='/discord_bot')