from corp_system.models import User
from corp_system import db

def test_user_creation(client):
    user = User(RSI_handle='testuser', password="LOL123456")
    db.session.add(user)
    db.session.commit()

    assert User.query.filter_by(RSI_handle='testuser').first() is not None
    assert user.check_password("LOL123456")
    
    user.log("banana", "I love them")
    assert user.logs[0]['type'] == "banana"
    assert user.logs[0]['data'] == "I love them"

def test_check_password(client):
    user = User(RSI_handle='testuser', password="LOL123456")
    db.session.add(user)
    db.session.commit()

    assert not user.check_password("wrongpassword")
    

def Test_password_hashing(client):
    user = User(RSI_handle='testuser', password="LOL123456")
    db.session.add(user)
    db.session.commit()

    assert user._password_hash != "LOL123456"