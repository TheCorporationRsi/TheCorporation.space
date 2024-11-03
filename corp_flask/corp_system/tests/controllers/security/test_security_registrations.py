import pytest
from corp_system.controllers.security_manager import SecurityManager
from corp_system.models import User, db


def test_register_password_too_short(client):
    # Setup
    RSI_handle = 'I_Love_My_Mom_and_my_cat'
    password = 'N_p123!'

    # Execute & Verify
    with pytest.raises(ValueError, match="Password must be between 8 and 32 characters long."):
        SecurityManager.register_user(RSI_handle, password)

def test_register_unexisten_handle(client):
    # Setup
    RSI_handle = 'I_Love_My_Mom_and_my_cat'
    password = 'New_password123!'

    # Execute & Verify
    with pytest.raises(ValueError, match="RSI handle doesn't exit"):
        SecurityManager.register_user(RSI_handle, password)

def test_register_existing_handle(client, new_user):
    # Setup
    existing_user = User.query.first()  # Assuming there is at least one user in the database
    RSI_handle = existing_user.RSI_handle
    password = 'New_password123!'

    # Execute & Verify
    with pytest.raises(ValueError, match="User already exists"):
        SecurityManager.register_user(RSI_handle, password)

def test_register_user_new(client):
    # Setup
    RSI_handle = 'Cyber-Dreamer'
    password = 'New_password123!'

    # Execute
    SecurityManager.register_user(RSI_handle, password)

    # Verify
    user = User.query.filter_by(RSI_handle=RSI_handle).first()
    assert user is not None
    assert user.RSI_handle == RSI_handle

    # Teardown
    db.session.delete(user)
    db.session.commit()