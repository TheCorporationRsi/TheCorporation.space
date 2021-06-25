import requests
import json

with open('/etc/config.json') as config_file:
    config = json.load(config_file)

class Oauth:
    SECRET_KEY = config.get('SECRET_KEY')
    client_id = config.get('DISCORD_ID')
    client_secret = config.get('DISCORD_SECRET')
    redirect_uri = "http://127.0.0.1:5000/discord_oauth"
    DISCORD_BOT_TOKEN = config.get('DISCORD_BOT_TOKEN')