import discord
from discord.ext import commands
import shutil


class initialization(commands.Cog):

    def __init__(self, client):
        self.client = client
        self.sio = client.sio

    @commands.Cog.listener()
    async def on_ready(self):
        print('We have logged in as {0.user}'.format(self.client))
        await self.sio.connect('http://localhost:8000', namespaces=['/discord_bot'])  
        print('my sid is', self.sio.sid)
        self.client.AppInfo = await self.client.application_info()
        user = self.client.AppInfo.owner
        await user.send("I\'m online!")



def setup(client):
    client.add_cog(initialization(client))
