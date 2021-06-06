from flask import render_template, request, Blueprint
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions, DiscordInteractionsBlueprint, Member, Role, Channel, Response
from corporation.models import Post, User, Division, Department, Rolevsuser
import discord
import enum

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

class Animal(enum.Enum):
    Dog = "dog"
    Cat = "cat"

@discord_actions.command(annotations={"choice": "Your favorite animal"})
def ping(ctx, choice: Member):
    "What is your favorite animal?"
    return f"{ctx.author.display_name} chooses {choice}!"