from flask import render_template, request, Blueprint
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions, DiscordInteractionsBlueprint, Member, Role, Channel
from corporation.models import Post, User, Division, Department, Rolevsuser
import discord

discord_bot_routes = Blueprint('discord_bot_routes', __name__)
discord_actions = DiscordInteractionsBlueprint()

lol = discord_actions.command_group("base", "Convert a number between bases")
banana = lol.subgroup("to", "Convert a number into a certain base")

@lol.command()
def bananalol(ctx):
    "Respond with a friendly 'pong'!"
    name = User.query.filter_by(id = 1).first().RSI_handle
    return name

@banana.command()
def bananana(ctx):
    "Respond with a friendly 'pong'!"
    name = User.query.filter_by(id = 1).first().RSI_handle
    return name

@discord_actions.command()
def ping(ctx):
    "Respond with a friendly 'pong'!"
    name = User.query.filter_by(id = 1).first().RSI_handle
    return name