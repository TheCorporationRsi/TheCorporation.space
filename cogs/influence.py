import discord
from discord.ext import commands
import shutil


class influence(commands.Cog):

    def __init__(self, client):
        self.client = client
        self.sio = client.sio

    """ @sio.event
    async def connect():
        print('Connection established to website')

    @sio.event
    async def disconnect():
        print('disconnected from server')
 """
 
    @commands.Cog.listener("on_raw_reaction_add")
    async def eventcreationreaction(self, reaction):
        print("emote!")
        serverid = reaction.guild_id
        guild = self.client.get_guild(serverid)
        userid = reaction.user_id
        #user = self.client.get_user(userid)
        author = guild.get_member(userid)
        channelid = reaction.channel_id
        channel = self.client.get_channel(channelid)
        messageid = reaction.message_id
        message = await channel.fetch_message(messageid)
        message_sender = message.author
        
        sio = self.client.sio
        if str(reaction.emoji) == '<:1INF:423754395944222721>':
            await sio.emit('influence_emote', {
            'sender': userid,
            'amount': 1,
            'receiver': message_sender.id,
            'message_id': messageid
            
            }, namespace='/discord_bot')
        elif str(reaction.emoji) == '<:5INF:423754398431313920>':
            await sio.emit('influence_emote', {
            'sender': userid,
            'amount': 5,
            'receiver': message_sender.id,
            'message_id': messageid
            
            }, namespace='/discord_bot')
        elif str(reaction.emoji) == '<:10INF:423754400297648131>':
            await sio.emit('influence_emote', {
            'sender': userid,
            'amount': 10,
            'receiver': message_sender.id,
            'message_id': messageid
            
            }, namespace='/discord_bot')
            
        #print(str(reaction.emoji))




def setup(client):
    client.add_cog(influence(client))
