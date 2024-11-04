import os
from abc import ABC
from datetime import timedelta


class Config_Model(ABC):
    DEBUG = False
    TESTING = False
    SECRET_KEY = os.environ["SECRET_KEY"]
    JWT_SECRET_KEY = os.environ["JWT_SECRET_KEY"]
    JWT_SESSION_COOKIE = False
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(minutes=10)
    JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=2)
    JWT_TOKEN_LOCATION = ["cookies"]
    JWT_ACCESS_COOKIE_NAME = "corp_access_pass"
    JWT_ACCESS_CSRF_COOKIE_NAME = "corp_access_pass_xeno_defense"
    JWT_REFRESH_COOKIE_NAME = "corp_refresh_pass"
    JWT_REFRESH_CSRF_COOKIE_NAME = "corp_refresh_pass_xeno_defense"
    JWT_COOKIE_CSRF_PROTECT = True
    JWT_COOKIE_SECURE = True
    GEVENT_SUPPORT = True

    SWAGGER = {
        "openapi": "3.0.0",
        "specs": [
            {
                "endpoint": "/api/specs",
                "route": "/api/apispec.json",
                "rule_filter": lambda rule: True,  # all in
                "model_filter": lambda tag: True,  # all in
            }
        ],
        "static_url_path": "/api/flasgger/static",
        "swagger_ui": True,
        "specs_route": "/api/docs",
    }

    JSONIFY_PRETTYPRINT_REGULAR = True
    SQLALCHEMY_DATABASE_URI = os.environ["SQLALCHEMY_DATABASE_URI"]
    # SQLALCHEMY_DATABASE_URI = os.environ['SQLALCHEMY_DATABASE_URI_CORP']
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_POOL_SIZE = 5
    SQLALCHEMY_ECHO = False
    SQLALCHEMY_BINDS = {
        #'rsi_stats_db': os.environ['SQLALCHEMY_DATABASE_URI_FUNDING']
    }

    SCHEDULER_API_ENABLED = True
    SCHEDULER_JOBSTORES = {"default": {"type": "memory"}}


class TestConfig(Config_Model):
    DEBUG = True
    TESTING = True
    PRESERVE_CONTEXT_ON_EXCEPTION = False

    JWT_COOKIE_SECURE = False

    JWT_COOKIE_CSRF_PROTECT = False

    SQLALCHEMY_DATABASE_URI = os.environ["SQLALCHEMY_DATABASE_TEST_URI"]
    SQLALCHEMY_BINDS = {"rsi_stats_db": os.environ["SQLALCHEMY_DATABASE_URI_FUNDING"]}


class DevelopmentConfig(Config_Model):
    DEBUG = True
    # RECAPTCHA_ENABLED = False


class Config:

    TestingConfig = TestConfig()
    ProductionConfig = Config_Model()
    DevelopmentConfig = DevelopmentConfig()
