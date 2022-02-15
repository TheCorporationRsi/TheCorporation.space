
import os
from abc import ABC


class Config_Model(ABC):
    DEBUG = False
    TESTING = False
    SECRET_KEY = os.environ['SECRET_KEY']
    JSONIFY_PRETTYPRINT_REGULAR = True
    SQLALCHEMY_DATABASE_URI = os.environ['SQLALCHEMY_DATABASE_URI']
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = False
    SQLALCHEMY_BINDS = {
    'rsi_stats_db': os.environ['SQLALCHEMY_DATABASE_URI_FUNDING']
    }

    SCHEDULER_API_ENABLED = True
    SCHEDULER_JOBSTORES = {
        'apscheduler.jobstores.default': {
            'type': 'sqlalchemy',
            'url': 'sqlite:///scheduler.db'
        }
    }
    
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ['EMAIL_USER']
    MAIL_PASSWORD = os.environ['EMAIL_PASS']
    DISCORD_CLIENT_ID = os.environ['DISCORD_ID']
    DISCORD_CLIENT_SECRET = os.environ['DISCORD_SECRET']
    DISCORD_REDIRECT_URI = os.environ['DISCORD_REDIRECT_URI']
    DISCORD_BOT_TOKEN = os.environ['DISCORD_BOT_TOKEN']
    DISCORD_PUBLIC_KEY = os.environ['DISCORD_PUBLIC_KEY']
    RECAPTCHA_USE_SSL = False
    RECAPTCHA_ENABLED = os.environ['RECAPTCHA_ENABLED']
    RECAPTCHA_PUBLIC_KEY = os.environ['RECAP_PUBKEY']
    RECAPTCHA_PRIVATE_KEY = os.environ['RECAP_PRVKEY']
    RECAPTCHA_DATA_ATTRS = {'theme': 'dark'}
    TESTING_GUILD = os.environ['DISCORD_TEST_SERVER']

class TestConfig(Config_Model):
    DEBUG = True
    TESTING = True
    PRESERVE_CONTEXT_ON_EXCEPTION = False
    SQLALCHEMY_DATABASE_URI = os.environ['SQLALCHEMY_DATABASE_TEST_URI']

    DISCORD_CLIENT_ID = os.environ['DISCORD_ID']
    DISCORD_CLIENT_SECRET = os.environ['DISCORD_SECRET']
    DISCORD_REDIRECT_URI = os.environ['DISCORD_REDIRECT_URI']
    DISCORD_BOT_TOKEN = os.environ['DISCORD_BOT_TOKEN']
    DISCORD_PUBLIC_KEY = os.environ['DISCORD_PUBLIC_KEY']

    TESTING_GUILD = os.environ['DISCORD_TEST_SERVER']

class DevelopmentConfig(Config_Model):
    DEBUG = True
    RECAPTCHA_ENABLED = False
class Config: 
    
    TestingConfig = TestConfig()
    ProductionConfig = Config_Model()
    DevelopmentConfig = DevelopmentConfig()

    