
import discord

import json
with open('/etc/config.json') as config_file:
    config = json.load(config_file)

client = discord.Client()

@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))
    user = await client.fetch_user(217337301364244480)
    await user.send("I\'m online!")

client.run(config.get('DISCORD_BOT_TOKEN'))
