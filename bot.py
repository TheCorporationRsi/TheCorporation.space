import discord
import os
from discord.ext import commands, ipc
import socketio

import json
with open('/etc/config.json') as config_file:
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


client = Bot(command_prefix = '$', intents = discord.Intents.default())
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


