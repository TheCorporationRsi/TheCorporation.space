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
login_manager.login_view = 'users.login'
login_manager.login_message_category = 'info'
scheduler = APScheduler()

with open('/etc/config.json') as config_file:
    config_info = json.load(config_file)


try:
    discord_bot = ipc.Client(
        secret_key=config_info.get('DISCORD_BOT_IPC_SECRET'))
    discord = DiscordOAuth2Session()
    mail = Mail()
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

    with app.app_context():

        if is_debug_mode() and not is_werkzeug_reloader_process():
            pass
        else:
            from corporation.influence import tasks  # noqa: F401

            scheduler.start()
        from corporation import events

        try:
            discord.init_app(app)
            discord_command = DiscordInteractions(app)
            mail.init_app(app)
        except:
            print("This application Multiple feature will not work properly")

        from corporation.users.routes import users
        from corporation.posts.routes import posts
        from corporation.main.routes import main
        from corporation.errors.handlers import errors
        from corporation.news.routes import news
        from corporation.managers.routes import managers
        from corporation.departments.routes import departments
        from corporation.discord_bot_routes.routes import discord_bot_routes
        from corporation.discord_bot_routes.routes import discord_actions
        from corporation.setup.routes import setup
        from corporation.influence.routes import influence
        from corporation.data.routes import data

        app.register_blueprint(users)
        app.register_blueprint(posts)
        app.register_blueprint(main)
        app.register_blueprint(errors)
        app.register_blueprint(news)
        app.register_blueprint(managers)
        app.register_blueprint(departments)
        app.register_blueprint(discord_bot_routes)
        discord_command.register_blueprint(discord_actions)
        app.register_blueprint(setup)
        app.register_blueprint(influence)
        app.register_blueprint(data)


    discord_command.set_route("/interactions")
    # discord_command.update_slash_commands(guild_id= 831248117571649566)

    return app