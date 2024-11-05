#from gevent import monkey
#monkey.patch_all()
#import eventlet

import os
import json
import sys


from pathlib import Path
from flask import Flask, jsonify, Response, request
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_apscheduler import APScheduler
from flask_socketio import SocketIO, emit
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from flask_wtf.csrf import CSRFProtect
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


jwt = JWTManager()
db = SQLAlchemy()
bcrypt = Bcrypt()
scheduler = APScheduler()
socketio = SocketIO(
    async_handlers=True, async_mode="threading", logger=True, engineio_logger=True
)  # , ,logger=True, engineio_logger=True, cors_allowed_origins=['http://localhost:8000', 'https://localhost:8000']
cors = CORS(resources={r"/api/*": {"origins": [os.environ["CORS_SETTING"]]}}, supports_credentials=True)
swagger = Swagger(
    template={
        "info": {
            "title": "The Corporation API",
            "description": "The underlying structural system of The Corporation and influence system",
            "contact": {
                "responsibleOrganization": "The Corporation",
                "responsibleDeveloper": "Cyber-Dreamer",
            },
            "termsOfService": None,
            "version": "0.0.1",
        },
        "servers": [
            {
                "url": os.environ["CORS_SETTING"],
                "description": "current_server"
            }
        ],
        "components": {
            "securitySchemes": {
                "cookieAuth": { 
                    "type": 'apiKey',
                    "in": 'cookie',
                    "name": 'corp_access_pass',
                },
                "csrf": { 
                    "name": 'X-CSRF-TOKEN',
                    "type": 'apiKey',
                    "in": 'header',
                },
                "csrf_refresh": { 
                    "name": 'X-CSRF-TOKEN',
                    "type": 'apiKey',
                    "in": 'header',
                },
                 "api_key": {
                    "name": 'X-API-Key',
                    "type": 'apiKey',
                    "in": 'header',
                }
            }
        },
        "security": {
            "cookieAuth": []
        },
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
            }
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

    # Associate the app with the SQLAlchemy models
    db.app = app

    # Initialize Flask-Migrate for handling database migrations
    Migrate(app, db)

    # Import the models after initializing the database
    with app.app_context():
        from . import models
        from . import tasks
        
        # Start the scheduler if not in debug mode
        if not is_debug_mode() or is_werkzeug_reloader_process():
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

        from flask_jwt_extended import (
            set_access_cookies,
            get_jwt,
            create_access_token,
            get_jwt_identity,
            current_user,
            unset_jwt_cookies,
            jwt_required,
        )
        from datetime import datetime, timezone, timedelta
        
        @app.before_request
        def log_request_info():
            app.logger.info("Request Headers: %s", request.headers)
            app.logger.info("Request Cookies: %s", request.cookies)

        @app.after_request
        def refresh_expiring_jwts(response):
            try:
                if not get_jwt_identity().disabled:
                    exp_timestamp = get_jwt()["exp"]
                    now = datetime.now(timezone.utc)
                    target_timestamp = datetime.timestamp(now + timedelta(hours=3))
                    if target_timestamp > exp_timestamp:
                        access_token = create_access_token(identity=get_jwt_identity())
                        set_access_cookies(response, access_token)
                else:
                    unset_jwt_cookies(response)
            except:
                # Case where there is not a valid JWT. Just return the original response
                return response

    return app
