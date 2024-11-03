from corp_system.models import User, Inf_Rank
import json

def test_profile_not_auth(client):

    protected_response = client.get('/api/v0/influence_system/profile')
    assert protected_response.status_code == 401  # Verify access is granted
    
def test_profile_not_CORP(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/influence_system/profile')
    assert protected_response.status_code == 401  # Verify access is granted

def test_profile(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    account = user.inf_account

    protected_response = client.get('/api/v0/influence_system/profile')
    assert protected_response.status_code == 200  # Verify access is granted
    account_rcv = protected_response.get_json()
    assert account_rcv['tribute'] == account.tribute_amount
    assert account_rcv['rank'] == account.rank.title
    