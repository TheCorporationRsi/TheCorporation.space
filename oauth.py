import requests
import json
from pathlib import Path
with open(Path(__file__).parent.absolute().as_posix()+'/config.json') as config_file:
    config = json.load(config_file)

class Oauth:
    SECRET_KEY = config.get('SECRET_KEY')
    client_id = config.get('DISCORD_ID')
    client_secret = config.get('DISCORD_SECRET')
    redirect_uri = "http://thecorporation.space/discord_oauth"
    DISCORD_BOT_TOKEN = config.get('DISCORD_BOT_TOKEN')