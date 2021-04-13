import discord
from discord.ext import commands
import shutil


class initialization(commands.Cog):

    def __init__(self, client):
        self.client = client

    @commands.Cog.listener()
    async def on_ready(self):
        print('We have logged in as {0.user}'.format(self.client))
        user = await self.client.fetch_user(217337301364244480)
        await user.send("I\'m online!")





def setup(client):
    client.add_cog(initialization(client))
