from flask import render_template, request, Blueprint, redirect, flash, url_for
from flask_login import current_user, login_required
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions, DiscordInteractionsBlueprint, Member, Channel, Response
#from flask_discord_interactions import ActionRow, Button, ButtonStyles
from flask_discord_interactions import Role as discord_role
from corporation.models import Post, User, Division, Department, Rolevsuser, Role
from corporation.discord_bot_routes.forms import Role_edit_Form
from corporation import db
from corporation import socketio
import discord
import enum
from corporation.discord_bot_routes import events
discord_bot_routes = Blueprint('discord_bot_routes', __name__)
discord_actions = DiscordInteractionsBlueprint()


@discord_bot_routes.route("/discord_role_setup", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@discord_bot_routes.route("/discord_role_setup/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@discord_bot_routes.route("/discord_role_setup/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def discord_role_setup(department, division):
    if not current_user.is_manager():
        return redirect(url_for('main.home'))

    update_form = Role_edit_Form(prefix="update")
    if update_form.update.data and update_form.validate_on_submit():
        role = Role.query.filter_by(id = update_form.role_id.data).first()
        role.discord_id = update_form.discord_id.data
        
        db.session.commit()
        flash('The Role has been updated!', 'success')
    
    if department == 0 and division == 0:
        roles = Role.query.order_by(Role.title).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division).order_by(Role.title).all()
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).order_by(Role.title).all()
        

    return render_template("discord_bot/discord_role_setup.html", title = "Role manager", roles = roles, currentdiv = division, currentdep = department, update_form = update_form)

''' lol = discord_actions.command_group("base", "Convert a number between bases")
banana = lol.subgroup("to", "Convert a number into a certain base") '''

''' @lol.command()
def bananalol(ctx):
    "Respond with a friendly 'pong'!"
    name = User.query.filter_by(id = 1).first().RSI_handle
    return name

@banana.command()
def bananana(ctx):
    "Respond with a friendly 'pong'!"
    name = User.query.filter_by(id = 1).first().RSI_handle
    return name

class Animal(enum.Enum):
    Dog = "dog"
    Cat = "cat" '''
role_enum = enum.Enum('DynamicEnum', {role.title:role.id for role in Role.query.filter_by(div_member=True).all()})
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