from concurrent.futures import wait
import discord
import os
from discord.ext import commands
import socketio
from pathlib import Path

intents = discord.Intents().all()
client = commands.Bot(command_prefix='$', description="This the CORP bot", intents=intents)
client.sio = socketio.AsyncClient()

connected = False

# Initialize websocket connection
@client.sio.on('connect', namespace='/discord_bot')
async def connect():
    print('Website Connected!')
    connected = True
    print('my sid is', client.sio.sid)

@client.sio.on('connect_error', namespace='/discord_bot')
async def connect_error(data):
    print("The connection failed!")
    connected = False
    
@client.sio.on('disconnect', namespace='/discord_bot')
async def disconnect():
    print("I'm disconnected!")
    connected = False

#====================================================

# Interaction handler

#====================================================

@client.event
async def on_message(message):
    if message.author.id == client.user.id:
        return
    user = await client.fetch_user(message.author.id)
    await client.sio.emit('discord_shell_call',{
            'user_id': message.author.id,
            'server_id': message.guild.id if message.guild else None ,
            'channel_id': message.channel.id,
            'message': message.content,
            'in_DM': message.channel.id == user.dm_channel.id,
            'username': message.author.name + '#' + message.author.discriminator
        } , namespace='/discord_bot')
    print(message.content + " sent to website")


@client.event
async def on_reaction_add(reaction, user):
    
    sender_id = reaction.user.id
    receiver_id = reaction.message.author.id
    message_id = reaction.message.id
    
    if str(reaction.emoji) == '<:1INF:423754395944222721>':
        
        await client.sio.emit('discord_influence_emote', {
        'sender_id': sender_id,
        'amount': 1,
        'receiver_id': receiver_id,
        'message_id': message_id
        }, namespace='/discord_bot')
        
    elif str(reaction.emoji) == '<:5INF:423754398431313920>':
        
        await client.sio.emit('discord_influence_emote', {
        'sender': sender_id,
        'amount': 5,
        'receiver': receiver_id,
        'message_id': message_id
        }, namespace='/discord_bot')
        
    elif str(reaction.emoji) == '<:10INF:423754400297648131>':
        
        await client.sio.emit('discord_influence_emote', {
        'sender': sender_id,
        'amount': 10,
        'receiver': receiver_id,
        'message_id': message_id
        }, namespace='/discord_bot')

@client.event
async def on_member_update(before, after):
    if len(before.roles) > len(after.roles):
            for role in before.roles:
                if role not in after.roles:
                    await client.sio.emit('role_removed', { 'user': before.id, 'role_id': role.id}, namespace='/discord_bot')
                    
    elif len(before.roles) < len(after.roles):
        for role in after.roles:
            if role not in before.roles:
                await client.sio.emit('role_added', { 'user': before.id, 'role_id': role.id}, namespace='/discord_bot')

#======================================================

# socketio Event listerners

#======================================================

@client.sio.on('discord_send_message', namespace='/discord_bot')
async def send_message(data):
    print("Received message from website")
    channel_id = data['channel_id']
    message = data['message']
    
    try:
        channel = await client.fetch_channel(channel_id)
        await channel.send(message)
    except:
        print("Unable to send message")


@client.sio.on('discord_dm_message', namespace='/discord_bot')
async def send_dm(data):
    print("Received message from website")
    user_id = data['user_id']
    message = data['message']
    
    try:
        user = await client.fetch_user(user_id)
        await user.send(message)
    except:
        print("Unable to send message")



@client.sio.on('change_nickname', namespace='/discord_bot')
async def change_nickname(data):
    user_id = data['member_id']
    nickname = data['nickname']
    
    guild = client.get_guild(831248117571649566)
    member = await guild.fetch_member(user_id)
    old_nickname = member.nick
    await member.edit(nick=nickname)


# Role manager

@client.sio.on('add_role', namespace='/discord_bot')
async def add_role(data):
    print("add")
    user_id = data['user']
    role_id = data['role_id']
    
    guild = client.get_guild(831248117571649566)
    role = guild.get_role(role_id)
    user = await guild.fetch_member(user_id)
    
    if role not in user.roles:
        await user.add_roles(role)

@client.sio.on('remove_role', namespace='/discord_bot')
async def remove_role(data):
    print("remove")
    user_id = data['user']
    role_id = data['role_id']
    
    guild = client.get_guild(831248117571649566)
    role = guild.get_role(role_id)
    user = await guild.fetch_member(user_id)
    
    if role in user.roles:
        await user.remove_roles(role)


@client.sio.on('upload_roles', namespace='/discord_bot')
async def upload_role(data):
    print("Uploading role!")
    user_id = data['user']
    guild = client.get_guild(831248117571649566)
    user = await guild.fetch_member(user_id)
    
    for role in user.roles:
        await client.sio.emit('role_added', { 'user': user_id, 'role_id': role.id}, namespace='/discord_bot')

#voice channel handler

@client.sio.on('voice_member_list', namespace='/discord_bot')
async def list_link(data):
    print("add")
    user_id = data['member_id']
    guild_id = data['server_id']
    channel_id = data['channel_id']
    guild = client.get_guild(guild_id)
    
    if user_id:
        user = await guild.fetch_member(int(user_id))
        channel_id = user.voice.channel.id
        channel = guild.get_channel(channel_id)
    else:
        channel_id = data['channel_id']
        channel = guild.get_channel(int(channel_id))
    
    if channel is None:
        return "You must be inside a voice channel!"
    
    else:
        list = {
            'user_list': []
        }
        members = channel.members
        for member in members:
            list['user_list'].append({
                'username': member.name + '#' + member.discriminator,
                'id': member.id,
            })
        return list


@client.event
async def on_ready():
    AppInfo = await client.application_info()
    user = AppInfo.owner
    await user.send("I\'m online!")
    await client.sio.connect('http://flask:8000', namespaces=['/discord_bot'])  

print("Starting.....")
client.run(os.environ['DISCORD_BOT_TOKEN'])




