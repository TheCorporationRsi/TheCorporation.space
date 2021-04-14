import discord
from discord.ext import commands
import shutil


class initialization(commands.Cog):

    def __init__(self, client):
        self.client = client





def setup(client):
    client.add_cog(initialization(client))
