from flask import render_template, request, Blueprint, redirect, flash, url_for
from flask_login import current_user, login_required
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions, DiscordInteractionsBlueprint, Member, Channel, Response
#from flask_discord_interactions import ActionRow, Button, ButtonStyles
from flask_discord_interactions import Role as discord_role
from project.models import User, Division, Department, Role
from project.discord_bot_routes.forms import Role_edit_Form
from project import db
from project import socketio
import discord
import enum
from project.discord_bot_routes import events
import time
from threading import Event
discord_bot_routes = Blueprint('discord_bot_routes', __name__)
discord_actions = DiscordInteractionsBlueprint()


     
#role_enum = enum.Enum('DynamicEnum', {role.title:role.id for role in Role.query.filter_by(type="Member").all()})
@discord_actions.command(name="assign_division",annotations={"member": "Select a member", "role": "Select a role"})
def give_role(ctx, member: Member, role: role_enum):
    "Adding division to a user ***admin only***"
    
    user = User.query.filter_by(discord_id = ctx.author.id).first()
    role = Role.query.filter_by(id = role).first()
    member = User.query.filter_by(discord_id = member.id).first()
    
    if not user:
        return f"{ctx.author.display_name}, you are not subscribed on the website!"
    elif not user.is_manager(division = role.division_id):
        return f"{ctx.author.display_name}, you are not a manager of that division!"
    elif not role:
        return f"Role not found!"
    elif role.dep_head or role.div_head or role.dep_proxy or role.div_proxy or role.title == "Corporateer":
        return f"{ctx.author.display_name}, this role cannot be assign by this command!"
    else:
        member.add_role(role)
        return f"{ctx.author.display_name} added {role.title} to {member.RSI_handle} !"
    

    

@discord_actions.command(name="send_tribute",annotations={"member": "Select a member", "amount": "Give an amount"})
def send_influence(ctx, member: Member, amount: int):
    "Sending your tribute to another member"
    
    sender_id = ctx.author.id
    sender = User.query.filter_by(discord_id = sender_id).first()
    receiver = User.query.filter_by(discord_id = member.id).first()
    
    if not sender:
        print('Sender not registered!')
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Unable to find your corporation account. Please make sure you are linked on the website"
            
            }, namespace='/discord_bot')
        
    elif not receiver:
        print('Receiver not registered!')
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Unable to find this member corporation account. Please make sure he link his account on the website"
            
            }, namespace='/discord_bot')
    elif receiver is sender:
        socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "You cannot send tribute to yourself!"
            
            }, namespace='/discord_bot')
    elif amount > 0 and sender.tribute().amount >= amount:
        status = sender.send_tribute( receiver, amount, message= "Sent by emote")
        if status == 0:
            socketio.emit('send_dm', {
            'member_id': sender_id,
            'message': "Transfer sucessful of "+ str(amount) +" tribute to "+ receiver.RSI_handle +"!"
            
            }, namespace='/discord_bot')
        return "Transfer sucessful of "+ str(amount) +" tribute to "+ receiver.RSI_handle +"!"

@discord_actions.command(name="update_member",annotations={"member": "Select a member"})
def update_member(ctx, member: Member):
    "Updating info and role of a user"
    member = User.query.filter_by(discord_id = member.id).first()
    
    if member:
        member.update_info()
        return "Member info updated!"
    else:
        return "Member not linked to the website"
    

division_enum = enum.Enum('DynamicEnum', {division.title:division.title for division in Division.query.all()})


@discord_actions.command(name="request_division",annotations={"division": "Select a division"})
def req_div(ctx, division:division_enum ):
    "Asking to join a division"
    member = User.query.filter_by(discord_id = ctx.author.id).first()
    if member:
        member.update_info()
        socketio.emit('send_message', {
            'channel_id': 859079316155793449,
            'message': "<@"+ str(ctx.author.id) +"> want to join "+ division + "."
            
            }, namespace='/discord_bot')
        return "Division requested!"
    else:
        return "Member not linked to the website"
    
''' @discord_actions.command(name="green_button")
def green_button(ctx):
    "Green button"
    
    return Response(
        content="search engine",
        components=[
            ActionRow(components=[
                Button(
                    style=ButtonStyles.LINK,
                    url="https://www.google.com/",
                    label="Go to google"
                )
            ])
        ]
    ) '''
    
class name_type(enum.Enum):
    Discord_and_link = "Discord + link"
    Discord_and_handle = "Discord + RSI_handle"
    RSI_handle_and_link = "RSI handle + link"
    RSI_handle_and_Moniker = "RSI handle + Moniker"
    RSI_handle_only = "RSI handle"
    
@discord_actions.command(name="list_link",annotations={"channel": "Select a channel", 'type':"Select  the format you want"})
def list_link(ctx, type: name_type = None, channel: Channel = None):
    "Get RSI link of all the users in a voice channel"
    result = None
    ev = Event()
    def callback(data):
        nonlocal result
        nonlocal ev
        
        print ("The data is: \n" + str(data))
        list = 'RSI link list:\n'
        
        if data['user_list']:
            for user in data['user_list']:
                member_account = User.query.filter_by(discord_id = user['id']).first()
                if member_account is None:
                    list += '<@'+ str(user['id']) + "> : Not linked\n"
                elif type == "RSI handle + link":
                    list += member_account.RSI_handle + " : <https://robertsspaceindustries.com/citizens/"+ str(member_account.RSI_handle) + ">\n"
                elif type == "Discord + RSI_handle":
                    list += '<@'+ str(user['id']) + "> : "+ str(member_account.RSI_handle) + "\n"
                elif type == "RSI handle + Moniker":
                    list += member_account.RSI_handle + " : "+ str(member_account.RSI_moniker) + "\n"
                elif type == "RSI handle":
                    list += member_account.RSI_handle + "\n"
                else :
                    list += '<@'+ str(user['id']) + "> : <https://robertsspaceindustries.com/citizens/"+ str(member_account.RSI_handle) + ">\n"
                
                
            print(list)
            result = list
            ev.set()
            return list
        else:
            result = data
            ev.set()
            return data
            
    member = User.query.filter_by(discord_id = ctx.author.id).first()
    
    if not member or not member.corp_confirmed:
        return 'You need to be a corp member to use this function!'
    
    if not channel or channel.type != 2:
        socketio.emit('voice_member_list', {
            'member_id': ctx.author.id
            
        }, namespace='/discord_bot', callback = callback )
        
        ev.wait()
        return result
    else:
        socketio.emit('voice_member_list', {
            'channel_id': channel.id,
            'member_id': ctx.author.id
            
        }, namespace='/discord_bot', callback = callback )  
        ev.wait()
        return result 