from corp_system.models import User
import json

def test_get_corporateer_not_auth(client):

    protected_response = client.get('/api/v0/corporateers/Cyber-Dreamer')
    assert protected_response.status_code == 401  # Verify access is granted
    
def test_get_corporateer_only_verified(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/corporateers/Cyber-Dreamer')
    assert protected_response.status_code == 401  # Verify access is granted

def test_get_corporateer(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True

    protected_response = client.get('/api/v0/corporateers/Cyber-Dreamer')
    assert protected_response.status_code == 200  # Verify access is granted
    member = protected_response.get_json()
    assert member['RSI_handle'] == user.RSI_handle
    assert member['RSI_moniker'] == user.RSI_moniker