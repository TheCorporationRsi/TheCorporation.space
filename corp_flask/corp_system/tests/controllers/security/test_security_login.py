import pytest
from corp_system.controllers.security_manager import SecurityManager
from corp_system.models import User, db


def test_login_invalid_handle(client, new_user):
    # Setup
    RSI_handle = 'I_Love_My_Mom_and_my_cat'
    password = 'new_p'

    # Execute & Verify
    with pytest.raises(ValueError, match="User not found"):
        SecurityManager.login_user(RSI_handle, password)

def test_login_2FA_missing(client, new_verified_user: User):
    # Setup
    RSI_handle = new_verified_user.RSI_handle
    password = 'new_p'

    # Execute & Verify
    with pytest.raises(ValueError, match="2FA missing"):
        SecurityManager.login_user(RSI_handle, password)

def test_login_2FA_error(client, new_verified_user: User):
    # Setup
    RSI_handle = new_verified_user.RSI_handle
    password = 'new_p'

    # Execute & Verify
    with pytest.raises(ValueError, match="2FA error"):
        SecurityManager.login_user(RSI_handle, password, otp='123456')

def test_login_password_error(client, new_verified_user: User):
    # Setup
    RSI_handle = new_verified_user.RSI_handle
    password = 'test_pass'

    # Execute & Verify
    with pytest.raises(ValueError, match="Incorrect password"):
        SecurityManager.login_user(RSI_handle, password, otp=new_verified_user.generate_otp())

def test_security_login(request_context, new_verified_user: User):
    # Setup
    RSI_handle = new_verified_user.RSI_handle
    password = 'Test_password123!'

    
    # Execute & Verify
    with request_context:
        response = SecurityManager.login_user(RSI_handle, password, otp=new_verified_user.generate_otp())
        
        assert response.status_code == 200
        assert 'Set-Cookie' in response.headers
        assert any('corp_access_pass' in header for header in response.headers.getlist('Set-Cookie'))
        assert any('corp_access_pass_xeno_defense' in header for header in response.headers.getlist('Set-Cookie'))
        assert any('corp_refresh_pass' in header for header in response.headers.getlist('Set-Cookie'))
        assert any('corp_refresh_pass_xeno_defense' in header for header in response.headers.getlist('Set-Cookie'))
        