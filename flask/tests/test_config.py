import json
from pathlib import Path
from project.config import Config

with open(Path(__file__).parent.parent.absolute().as_posix() +'/project/config.json') as config_file:
    config = json.load(config_file)

""" def test_development_config(app):
    assert app.config['DEBUG']
    assert not app.config['TESTING']
    assert app.config['SQLALCHEMY_DATABASE_URI'] == config.get('SQLALCHEMY_DATABASE_URI')
    assert app.config['SQLALCHEMY_BINDS'] == {
    'rsi_stats_db': 'sqlite:///rsi_stats.db'
    } """

def test_testing_config(app):
    assert app.config['DEBUG']
    assert app.config['TESTING']
    assert not app.config['PRESERVE_CONTEXT_ON_EXCEPTION']
    assert app.config['SQLALCHEMY_DATABASE_URI'] == config.get('SQLALCHEMY_DATABASE_TEST_URI')
    assert app.config['SQLALCHEMY_BINDS'] == {
    'rsi_stats_db': 'sqlite:///rsi_stats_test.db'
    }
""" 
def test_production_config(app):
    app.config.from_object(Config.ProductionConfig)
    assert not app.config['DEBUG']
    assert not app.config['TESTING']
    assert app.config['SQLALCHEMY_DATABASE_URI'] == config.get('SQLALCHEMY_DATABASE_URI')
    assert app.config['SQLALCHEMY_BINDS'] == {
    'influence_db': 'sqlite:///influence.db',
    'logs_db':  'sqlite:///logs.db',
    'rsi_stats_db': 'sqlite:///rsi_stats.db'
    } """