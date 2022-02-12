from project.models import User
import json
from project import  db

def test_add_user(test_app):
    """Ensure a new user can be added to the database."""
    user = User(RSI_handle= "Cyber_Dreamer", email="test@test.com", password="test123456")
    db.session.add(user)
    db.session.commit()

    assert User.query.filter_by(RSI_handle="Cyber_Dreamer").first() == user


def test_user_property(test_app, new_user):
    """
    GIVEN a User model
    WHEN a new User is created
    THEN check the email, hashed_password, and role fields are defined correctly
    """
   
    assert new_user.email == 'lol@hotmail.com'
    assert new_user.RSI_handle == 'test'
    assert new_user.RSI_handle != 'bob'
    assert new_user.password != 'test123456'
    assert new_user.test_password('test123456')
    assert new_user.test_password('this_is_wrong') is False
    assert new_user.test_password(new_user.password) is False
    assert new_user.registered is False
    assert new_user.image_file == 'default.jpg'
    assert new_user.discord_username is None
    assert new_user.discord_id is None
    assert new_user.guilded_username is None
    assert new_user.guilded_id is None
    assert new_user.login_attempt == 2
    assert new_user.test_password('test123456')
    assert new_user.login_attempt == 0
    assert new_user.email_confirmed is False
    assert new_user.corp_confirmed is False

def test_password_security(test_app, new_user):
    """
    GIVEN a User model
    WHEN a new User is created
    THEN check the password features are secure
    """
    
    assert new_user.login_attempt == 0
    assert new_user.test_password('this_is_wrong') is False
    assert new_user.login_attempt == 1
    assert new_user.test_password('this_is_wrong') is False
    assert new_user.login_attempt == 2
    assert new_user.test_password('this_is_wrong') is False
    assert new_user.login_attempt == 3
    assert new_user.test_password('test123456') is False
    assert new_user.login_attempt == 4



    

