import discord
from discord.ext import commands
import shutil

import discord
from discord.ext import commands
import shutil

class role_manager(commands.Cog):

    def __init__(self, client):
        self.client = client
        self.sio = client.sio

    @commands.Cog.listener()
    async def on_member_update(self, before, after):
        if len(before.roles) > len(after.roles):
            for role in before.roles:
                if role not in after.roles:
                    await self.client.sio.emit('role_removed', { 'user': before.id, 'role_id': role.id}, namespace='/discord_bot')
        elif len(before.roles) < len(after.roles):
            for role in after.roles:
                if role not in before.roles:
                    await self.sio.emit('role_added', { 'user': before.id, 'role_id': role.id}, namespace='/discord_bot')
    


def setup(client):
    client.add_cog(role_manager(client))
