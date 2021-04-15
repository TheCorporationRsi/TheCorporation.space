from flask import render_template, request, Blueprint
from flask import Blueprint
from flask_discord_interactions import DiscordInteractions
import discord

discord_bot_routes = Blueprint('discord_bot_routes', __name__)
discord_actions = DiscordInteractionsBlueprint()

@discord_actions.command()
def ping(ctx):
    "Respond with a friendly 'pong'!"
    return "lol"