from corp_system import socketio
import os
import threading
import subprocess
from .context_model import Context, Argument

from corp_system.bot.connector_model import Bot_space
socketio.on_namespace(Bot_space('/discord_bot', api_key=os.environ["DISCORD_FLASK_API_KEY"], service_name='discord', context_model=Context, namespace_name='/discord_bot'))

