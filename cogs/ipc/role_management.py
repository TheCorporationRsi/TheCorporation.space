import discord
from discord.ext import commands, ipc
import shutil


class role_manager(commands.Cog):

    def __init__(self, client):
        self.client = client
        self.server_id = 831248117571649566
        
    

    
    @ipc.server.route() 
    async def get_roles(self, data):
        server = self.client.get_guild(self.server_id)
        
        
        return server.roles



def setup(client):
    client.add_cog(role_manager(client))
