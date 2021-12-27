import discord
import os
from discord.ext import commands, ipc
import socketio
from pathlib import Path

import json
with open(Path(__file__).parent.parent.absolute().as_posix() +'/config.json') as config_file:
    config = json.load(config_file)
    
class Bot(commands.Bot):
    
    def __init__(self,*args,**kwargs):
        super().__init__(*args, **kwargs)

        self.ipc = ipc.Server(self, secret_key = config.get('DISCORD_BOT_IPC_SECRET'))
        
        for filename in os.listdir('./cogs/ipc'):
            if filename.endswith('.py'):
                self.load_extension(f'cogs.ipc.{filename[:-3]}')
        
    async def on_ready(self):
            print('We have logged in as {0.user}'.format(self))
            user = await self.fetch_user(217337301364244480)
            await user.send("I\'m online!")
            
    async def on_ipc_ready(self):
            print("Ipc is ready.")
            
    async def on_ipc_error(self, endpoint, error):
            print(endpoint, "raised", error)

intents = discord.Intents().all()
client = Bot(command_prefix = '$', intents = intents)
client.sio = socketio.AsyncClient()

@client.sio.on('connect', namespace='/discord_bot')
async def connect():
    print('Website Connected!')

@client.sio.on('infuence_error', namespace='/discord_bot')
async def influence_error(data):
    sender = data['sender']
    amount = data['amount']
    receiver = data['receiver']
    message_id = data['message_id']
    print(str(sender))
    try:
        sender = await client.fetch_user(sender)
        await sender.send("Unable to send influence to this user.")
    except:
        print("Sender doesn't exist")
    
    try:
        receiver = await client.fetch_user(receiver)
        await receiver.send("Unable to send influence to this user.")
    except:
        print("Receiver doesn't exist")
        
    print('Error during the transfer')

@client.sio.on('send_dm', namespace='/discord_bot')
async def send_dm(data):
    user_id = data['member_id']
    message = data['message']
    
    try:
        user = await client.fetch_user(user_id)
        await user.send(message)
    except:
        print("Sender doesn't exist")

@client.sio.on('send_message', namespace='/discord_bot')
async def send_message(data):
    channel_id = data['channel_id']
    message = data['message']
    
    try:
        channel = await client.fetch_channel(channel_id)
        await channel.send(message)
    except:
        print("Unable to send message")
        
@client.sio.on('change_nickname', namespace='/discord_bot')
async def send_dm(data):
    user_id = data['member_id']
    nickname = data['nickname']
    
    guild = client.get_guild(831248117571649566)
    member = await guild.fetch_member(user_id)
    old_nickname = member.nick
    await member.edit(nick=nickname)
     

@client.sio.on('delete_role', namespace='/discord_bot')
async def remove_role(data):
    print("remove")
    user_id = data['user']
    role_id = data['role_id']
    
    guild = client.get_guild(831248117571649566)
    role = guild.get_role(role_id)
    user = await guild.fetch_member(user_id)
    
    if role in user.roles:
        await user.remove_roles(role)

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
    
@client.sio.on('upload_roles', namespace='/discord_bot')
async def upload_role(data):
    print("Uploading role!")
    user_id = data['user']
    guild = client.get_guild(831248117571649566)
    user = await guild.fetch_member(user_id)
    
    for role in user.roles:
        await client.sio.emit('role_added', { 'user': user_id, 'role_id': role.id}, namespace='/discord_bot')
        
@client.sio.on('voice_member_list', namespace='/discord_bot')
async def list_link(data):
    print("add")
    user_id = data['member_id']
    guild = client.get_guild(831248117571649566)
    
    if not 'channel_id' in data:
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
                'username': member.nick,
                'id': member.id,
            })
        return list
    
@client.command()
@commands.is_owner()
@commands.dm_only()
async def load(ctx, extension):
    client.load_extension(f'cogs.{extension}')

@client.command()
@commands.is_owner()
@commands.dm_only()
async def unload(ctx, extension):
    client.unload_extension(f'cogs.{extension}')

@client.command()
@commands.is_owner()
@commands.dm_only()
async def reload(ctx, extension):
    client.unload_extension(f'cogs.{extension}')
    client.load_extension(f'cogs.{extension}')

@client.command()
@commands.is_owner()
@commands.dm_only()
async def reloadall(ctx):
    for filename in os.listdir('./cogs'):
        if filename.endswith('.py'):
            client.unload_extension(f'cogs.{filename[:-3]}')
    for filename in os.listdir('./cogs'):
        if filename.endswith('.py'):
            client.load_extension(f'cogs.{filename[:-3]}')
    await ctx.send('Done!')


for filename in os.listdir('./cogs'):
    if filename.endswith('.py'):
        client.load_extension(f'cogs.{filename[:-3]}')

    
client.ipc.start()
client.run(config.get('DISCORD_BOT_TOKEN'))


