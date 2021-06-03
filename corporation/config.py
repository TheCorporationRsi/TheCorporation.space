
import os
import json
with open('/etc/config.json') as config_file:
    config = json.load(config_file)

class Config: 
    SECRET_KEY = config.get('SECRET_KEY')
    SQLALCHEMY_DATABASE_URI = config.get('SQLALCHEMY_DATABASE_URI')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = False
    SQLALCHEMY_BINDS = {
    'influence_db': 'sqlite:///influence.db',
    'role_db': 'sqlite:///role.db',
    'social_db': 'sqlite:///social.db',
    'logs_db':  'sqlite:///logs.db'
    }

    SCHEDULER_API_ENABLED = True
    SCHEDULER_JOBSTORES = {
        'apscheduler.jobstores.default': {
            'type': 'sqlalchemy',
            'url': SQLALCHEMY_DATABASE_URI
        }
    }
    
    try:
        MAIL_SERVER = 'smtp.gmail.com'
        MAIL_PORT = 587
        MAIL_USE_TLS = True
        MAIL_USERNAME = config.get('EMAIL_USER')
        MAIL_PASSWORD = config.get('EMAIL_PASS')
        DISCORD_CLIENT_ID = config.get('DISCORD_ID')
        DISCORD_CLIENT_SECRET = config.get('DISCORD_SECRET')
        DISCORD_REDIRECT_URI = config.get('DISCORD_REDIRECT_URI')
        DISCORD_BOT_TOKEN = config.get('DISCORD_BOT_TOKEN')
        DISCORD_PUBLIC_KEY = config.get('DISCORD_PUBLIC_KEY')
        RECAPTCHA_USE_SSL = False
        RECAPTCHA_PUBLIC_KEY = config.get('RECAP_PUBKEY')
        RECAPTCHA_PRIVATE_KEY = config.get('RECAP_PRVKEY')
        RECAPTCHA_DATA_ATTRS = {'theme': 'dark'}
        TESTING_GUILD = 831248117571649566
    except:
        print("This application Multiple feature will not work properly")
        
    