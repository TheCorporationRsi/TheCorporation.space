# from gevent import monkey
# monkey.patch_all()
# import eventlet

import os
import json
import sys


from pathlib import Path
from flask import Flask, jsonify, Response, request, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_apscheduler import APScheduler
from flask_socketio import SocketIO, emit
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from flask_wtf.csrf import CSRFProtect
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from flask_cors import CORS
from flasgger import Swagger
from .config import Config

from logging.handlers import RotatingFileHandler
import logging


def is_debug_mode():
    """Get app debug status."""
    debug = os.environ.get("FLASK_DEBUG")
    if not debug:
        return os.environ.get("FLASK_ENV") == "development"
    return debug.lower() not in ("0", "false", "no")


def is_werkzeug_reloader_process():
    """Get werkzeug status."""
    return os.environ.get("WERKZEUG_RUN_MAIN") == "true"


limiter = Limiter(key_func=get_remote_address, default_limits=["200 per minute"])
jwt = JWTManager()
db = SQLAlchemy()
bcrypt = Bcrypt()
scheduler = APScheduler()
socketio = SocketIO(
    async_handlers=True, async_mode="threading", logger=True, engineio_logger=True
)  # , ,logger=True, engineio_logger=True, cors_allowed_origins=['http://localhost:8000', 'https://localhost:8000']
cors = CORS(
    resources={r"/api/*": {"origins": [os.environ["CORS_SETTING"]] if os.environ["ALLOW_ALL_ORIGIN"] == "False" else "*"}},
    supports_credentials=True,
)
swagger = Swagger(
    template={
        "info": {
            "title": "The Corporation API",
            "description": "The underlying structural system of The Corporation and influence system",
            "termsOfService": "http://swagger.io/terms/",
            "contact": {"email": "apiteam@swagger.io"},
            "license": {
                "name": "AGPL 3.0",
                "url": "https://www.gnu.org/licenses/agpl-3.0.html",
            },
            "version": "0.0.1",
        },
        "externalDocs": {
            "description": "Find out more about Swagger",
            "url": "http://swagger.io",
        },
        "servers": [
            {"url": os.environ["CORS_SETTING"], "description": "current_server"}
        ],
        "components": {
            "securitySchemes": {
                "corp_access_pass": {
                    "type": "http",
                    "scheme": "bearer",
                },
                "corp_refresh_pass": {
                    "type": "http",
                    "scheme": "bearer",
                },
                "api_key": {
                    "name": "X-API-Key",
                    "type": "apiKey",
                    "in": "header",
                },
            },
            "responses": {
                "unauthorized": {
                    "description": "Access denied",
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "object",
                                "properties": {
                                    "msg": {
                                        "type": "string", 
                                        "example": "Need to be a corp member"}
                                }
                            }
                        }
                    }
                },
                "invalid": {
                    "description": "An error happen with the info that you submitted",
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "object",
                                "properties": {
                                    "msg": {
                                        "type": "string", 
                                        "example": "Need to be a corp member"}
                                }
                            }
                        }
                    },
                }
                
            }
        },
        "security": [],
        "tags": [
            {
                "name": "Influence System",
                "description": "Endpoints of the influence system",
            },
            {
                "name": "Security",
                "description": "Endpoints for authentification",
            },
            {
                "name": "Information",
                "description": "Endpoints of various CORP informations",
            },
            {
                "name": "Structure",
                "description": "Endpoints for the corporation structure",
            },
            {
                "name": "RSI Stats",
                "description": "Endpoints for store RSI stats",
            },
            {
                "name": "Admin",
                "description": "Endpoints to administer the website",
            },
        ],
    }
)


def create_app(config_class=Config.ProductionConfig):

    # Create a Flask application instance
    app = Flask(__name__)

    # Load the configuration from the Config object
    app.config.from_object(config_class)

    if "pytest" in sys.modules:
        # Modify the database URI based on the worker ID
        worker_id = os.environ.get(
            "PYTEST_XDIST_WORKER", "gw0"
        )  # Default to 'gw0' if not using xdist
        base_uri = os.environ["SQLALCHEMY_DATABASE_TEST_URI"]
        test_db_uri = f"{base_uri}_{worker_id}"  # Append worker ID to the base URI
        print(f"Using test database URI: {test_db_uri}")
        app.config["SQLALCHEMY_DATABASE_URI"] = test_db_uri

    # Set up logging
    handler = RotatingFileHandler("./app.log", maxBytes=10000, backupCount=10)
    handler.setLevel(logging.INFO)
    app.logger.addHandler(handler)

    """
    @app.route('/logs', methods=['GET'])
    def get_logs():
        with open('app.log', 'r') as f:
            log_data = f.read()
        return Response(log_data, mimetype='text/plain')
    """

    # Initialize extensions with the Flask application
    jwt.init_app(app)
    db.init_app(app)
    bcrypt.init_app(app)
    scheduler.init_app(app)
    socketio.init_app(app)
    cors.init_app(app)
    swagger.init_app(app)

    # Add a sample task to verify scheduler

    # Associate the app with the SQLAlchemy models
    db.app = app

    # Initialize Flask-Migrate for handling database migrations
    Migrate(app, db)

    # Import the models after initializing the database
    with app.app_context():
        from . import models
        from . import tasks
        from . import bot

        scheduler.start()

        # Import the events after starting the scheduler
        from . import events

        # Import the bot controller and API blueprint
        # import .api.bots.controller as bot_controller
        from .api import api

        # Register the API blueprint
        app.register_blueprint(api, url_prefix="/api")

        # Create all database tables
        db.create_all()

        from .models import Role, Inf_Rank

        if Role.query.filter_by(title="Corporateer").first() is None:
            db.session.add(Role(title="Corporateer"))
            db.session.commit()

        if Inf_Rank.query.filter_by(title="Corporateer").first() is None:
            db.session.add(
                Inf_Rank(
                    title="Corporateer", required_lifetime_influence=0, weekly_amount=50
                )
            )
            db.session.commit()

    return app
