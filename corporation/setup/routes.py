from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord_bot
from corporation.models import Post, User, Role, Division, Department, Rolevsuser
from flask_discord import requires_authorization
from corporation.setup.forms import Role_Form
import requests
import json
import asyncio

import discord
from discord.ext import ipc

""" with open('/etc/config.json') as config_file:
    config_info = json.load(config_file)


discord_bot = ipc.Client(secret_key = config_info.get('DISCORD_BOT_IPC_SECRET')) """

setup = Blueprint('setup', __name__)

server_id = 831248117571649566


# ================================================= Role =========================================================
@setup.route("/discord/role_setup", defaults={"department": 0, "division": 0}, methods=['GET', 'POST'])
@setup.route("/discord/role_setup/<int:department>", defaults={"division": 0}, methods=['GET', 'POST'])
@setup.route("/discord/role_setup/<int:department>/<int:division>", methods=['GET', 'POST'])
@login_required
def role_setup(department, division):

    discord_role = asyncio.run(discord_bot.request("get_roles"))
    for role in discord_role:
        print(role)


    if division > 0:
        if not current_user.is_manager(division=division):
            return redirect(url_for('main.home'))
    else:
        if not current_user.is_manager(department = department, division = division):
            return redirect(url_for('main.home'))
    
    form = Role_Form()
    if form.validate_on_submit():
        if department > 0 and division > 0:
            division = Division.query.filter_by(id = division ).first()
            role = Role(title= form.title.data, division= division, department= department ,created_by= current_user.id)
        elif department > 0:
            role = Role(title= form.title.data, department= department ,created_by= current_user.id)
        else:
            role = Role(title= form.title.data, created_by= current_user.id)
        db.session.add(role)
        db.session.commit()
        flash('Role has been created!', 'success')
        return redirect(url_for('managers.role_manager'))
    
    if department == 0 and division == 0:
        roles = Role.query.order_by(Role.title).all()
    elif division > 0:
        roles = Role.query.filter_by(division_id = division).order_by(Role.title).all()
    elif department > 0:
        roles = Role.query.filter_by(department_id = department).order_by(Role.title).all()
        
    
    divisions = Division.query.order_by(Division.title).all()
    departments = Department.query.order_by(Department.title).all()
    
    return render_template("managers/role_manager.html", title = "Role manager", roles = roles, Role = Role,  form=form, divisions = divisions, departments = departments, currentdiv = division, currentdep = department)
