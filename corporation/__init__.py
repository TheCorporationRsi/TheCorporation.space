import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_mail import Mail
from corporation.config import Config
from flask_discord import DiscordOAuth2Session
import json
from flask_discord_interactions import DiscordInteractions
from flask_apscheduler import APScheduler
from sqlalchemy import MetaData
from flask_socketio import SocketIO, emit
from pathlib import Path
import eventlet

import discord
from discord.ext import ipc


def is_debug_mode():
    """Get app debug status."""
    debug = os.environ.get("FLASK_DEBUG")
    if not debug:
        return os.environ.get("FLASK_ENV") == "development"
    return debug.lower() not in ("0", "false", "no")


def is_werkzeug_reloader_process():
    """Get werkzeug status."""
    return os.environ.get("WERKZEUG_RUN_MAIN") == "true"


naming_convention = {
    "ix": 'ix_%(column_0_label)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(column_0_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}

db = SQLAlchemy(metadata=MetaData(naming_convention=naming_convention))
bcrypt = Bcrypt()
login_manager = LoginManager()
login_manager.login_view = 'security.login'
login_manager.login_message_category = 'info'
scheduler = APScheduler()
socketio = SocketIO( async_handlers=True, cors_allowed_origins=['http://localhost:8000', 'https://localhost:8000'], async_mode = 'gevent') # ,logger=True, engineio_logger=True

with open(Path(__file__).parent.parent.parent.absolute().as_posix() +'/config.json') as config_file:
    config_info = json.load(config_file)


try:
    mail = Mail()
    discord = DiscordOAuth2Session()
except:
    print("This application is not set properly. Multiple feature will not work properly")

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    db.app = app
    bcrypt.init_app(app)
    login_manager.init_app(app)
    scheduler.init_app(app)
    socketio.init_app(app)
    
    with app.app_context():

        if is_debug_mode() and not is_werkzeug_reloader_process():
            pass
        else:
            from corporation.influence import tasks  # noqa: F401
            from corporation.data import tasks
            
            scheduler.start()
        from corporation import events

        try:
            discord.init_app(app)
            discord_command = DiscordInteractions(app)
            mail.init_app(app)
        except:
            print("This application Multiple feature will not work properly")

        from corporation.dashboard import dashboard
        from corporation.security import security
        from corporation.main.routes import main
        from corporation.security.errors.handlers import errors
        from corporation.managers import managers
        from corporation.discord_bot_routes.routes import discord_bot_routes
        from corporation.discord_bot_routes.routes import discord_actions
        from corporation.setup.routes import setup
        from corporation.influence.routes import influence
        from corporation.data.api import data
        from corporation.chart import chart

        
        app.register_blueprint(security)
        app.register_blueprint(main)
        app.register_blueprint(errors)
        app.register_blueprint(managers)
        app.register_blueprint(discord_bot_routes)
        discord_command.register_blueprint(discord_actions)
        app.register_blueprint(setup)
        app.register_blueprint(influence)
        app.register_blueprint(data)
        app.register_blueprint(dashboard)
        app.register_blueprint(chart)

    discord_command.set_route("/interactions")
    #discord_command.update_slash_commands(guild_id= 831248117571649566)
    
    return app