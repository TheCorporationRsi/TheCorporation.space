import discord
from discord.ext import commands
import shutil


class role_manager(commands.Cog):

    def __init__(self, client):
        self.client = client





def setup(client):
    client.add_cog(role_manager(client))