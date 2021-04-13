import discord
import os
from discord.ext import commands

import json
with open('/etc/config.json') as config_file:
    config = json.load(config_file)

client = commands.Bot(command_prefix = '$')


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


client.run(config.get('DISCORD_BOT_TOKEN'))
