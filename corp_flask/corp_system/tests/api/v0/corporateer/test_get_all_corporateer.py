from corp_system.models import User
import json

def test_corporateer_not_auth(client):

    protected_response = client.get('/api/v0/corporateers')
    assert protected_response.status_code == 401  # Verify access is granted
    
def test_corporateer_only_verified(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/corporateers')
    assert protected_response.status_code == 401  # Verify access is granted

def test_corporateer(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True

    protected_response = client.get('/api/v0/corporateers')
    assert protected_response.status_code == 200  # Verify access is granted
    members = protected_response.get_json()
    assert members[0]['RSI_handle'] == user.RSI_handle
    assert members[0]['RSI_moniker'] == user.RSI_moniker