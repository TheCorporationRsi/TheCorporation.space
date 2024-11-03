import pytest
from corp_system.controllers.security_manager import SecurityManager
from corp_system.models import User, db


def test_get_rsi_token_unkown_user(client, new_user):
    # Setup
    RSI_handle = 'I_Love_My_Mom_and_my_cat'

    # Execute & Verify
    with pytest.raises(ValueError, match="User not found"):
        SecurityManager.rsi_token(RSI_handle)
        
def test_get_rsi_token_kown_user(client, new_user):
    # Setup
    # Execute & Verify
    
    token = SecurityManager.rsi_token(new_user.RSI_handle)
    assert token is not None