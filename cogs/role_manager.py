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
                    channel = await self.client.fetch_channel(860555929132597280)
                    embed=discord.Embed(title= "Role removed", description= role.name + " removed to <@"+ str(before.id) +">", color= role.color )
                    await channel.send(embed=embed)
                    #str(role.name) + " role has been removed to <@"+ str(before.id) + ">."
        elif len(before.roles) < len(after.roles):
            for role in after.roles:
                if role not in before.roles:
                    await self.sio.emit('role_added', { 'user': before.id, 'role_id': role.id}, namespace='/discord_bot')
                    channel = await self.client.fetch_channel(860555929132597280)
                    embed=discord.Embed(title= "Role added", description= role.name + " added to <@"+ str(before.id) +">", color= role.color )
                    await channel.send(embed=embed)
        
        if before.nick != after.nick:
            channel = await self.client.fetch_channel(860555929132597280)
            embed=discord.Embed(title= "Nickname changed", description= "<@"+ str(before.id) +"> nickname was: "+ before.display_name, color= 0x007bff)
            await channel.send(embed=embed)
    


def setup(client):
    client.add_cog(role_manager(client))
