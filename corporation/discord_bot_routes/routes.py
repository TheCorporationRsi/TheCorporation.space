from flask import render_template, request, Blueprint, redirect, flash, url_for
from flask_login import current_user, login_required
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions, DiscordInteractionsBlueprint, Member, Channel, Response
from flask_discord_interactions import Role as discord_role
from corporation.models import Post, User, Division, Department, Rolevsuser, Role
from corporation.discord_bot_routes.forms import Role_edit_Form
from corporation import db
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

@discord_actions.command(name="add_role",annotations={"member": "Select a member", "role": "Select a role"})
def give_role(ctx, member: Member, role: discord_role):
    "Adding role to a user ***admin only***"
    
    user = User.query.filter_by(discord_id = ctx.author.id).first()
    role = Role.query.filter_by(discord_id = role.id).first()
    member = User.query.filter_by(discord_id = member.id).first()
    
    if not user:
        return f"{ctx.author.display_name}, you are not subscribed on the website!"
    elif not user.is_manager():
        return f"{ctx.author.display_name}, you are not a manager!"
    elif not role:
        return f"Role not sync with the website!"
    elif role.dep_head or role.div_head or role.dep_proxy or role.div_proxy:
        return f"{ctx.author.display_name}, those role cannot be assign by this command!"
    else:
        member.add_role(role)
        return f"{ctx.author.display_name} added {role.title} to {member.RSI_handle} !"
    
