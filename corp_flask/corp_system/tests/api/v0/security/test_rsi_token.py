from corp_system.models import User
import json

def test_RSI_token_not_auth(client):

    protected_response = client.get('/api/v0/RSI_token')
    assert protected_response.status_code == 401  # Verify access is granted

def test_RSI_token(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()

    protected_response = client.get('/api/v0/RSI_token')
    assert protected_response.status_code == 200  # Verify access is granted
    token = protected_response.get_json()["RSI_token"]
    assert token == user.RSI_verification_token