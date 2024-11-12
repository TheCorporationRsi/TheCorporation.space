from corp_system.models import User, Inf_Rank
import json

def test_transfer_not_auth(client):

    protected_response = client.post('/api/v0/influence_system/transfer')
    assert protected_response.status_code == 401  # Verify access is granted
    
def test_transfer_not_CORP(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.post('/api/v0/influence_system/transfer')
    assert protected_response.status_code == 401  # Verify access is granted

def test_transfer(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": new_user2.RSI_handle,
        "amount": 10,
        "message": "I love cat"
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    response = protected_response.get_json()
    assert response['msg'] == "Transfer successfull!"
    
    assert protected_response.status_code == 200  # Verify access is granted
    assert cyber_account.tribute_amount == other_account.tribute_amount - 10
    assert cyber_account.current_influence() == 10
    assert cyber_account.lifetime_influence() == 10
    assert other_account.current_influence() == 10
    assert other_account.lifetime_influence() == 10


def test_transfer_not_enough_tribute(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": new_user2.RSI_handle,
        "amount": 1000,
        "message": "I love cat"
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    assert protected_response.status_code == 400  # Verify access is granted
    
    response = protected_response.get_json()
    assert response['msg'] == "Sender does not have enough tribute"

def test_transfer_under_1(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": new_user2.RSI_handle,
        "amount": -5,
        "message": "I love cat"
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    assert protected_response.status_code == 400  # Verify access is granted
    
    response = protected_response.get_json()
    assert response['msg'] == "Amount must be greater than 0"
    

def test_transfer_member_not_found(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": "bob",
        "amount": 10,
        "message": "I love cat"
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    assert protected_response.status_code == 400  # Verify access is granted
    
    response = protected_response.get_json()
    assert response['msg'] == "Member not found"

def test_transfer_message_not_string(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": new_user2.RSI_handle,
        "amount": 1000,
        "message": 10
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    assert protected_response.status_code == 400  # Verify access is granted
    
    response = protected_response.get_json()
    assert response['msg'] == "Message must be string"
    

def test_transfer_message_too_long(cyber_client, new_user2):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    new_user2.RSI_confirmed = True
    new_user2.CORP_confirmed = True
    
    cyber_account = user.inf_account
    other_account = new_user2.inf_account
    
    cyber_account.tribute_amount = 100
    other_account.tribute_amount = 100

    protected_response = client.post('/api/v0/influence_system/transfer',json={
        "receiver_handle": new_user2.RSI_handle,
        "amount": 100,
        "message": "a"*300
    }, headers={'X-CSRF-TOKEN': csrf_token})
    
    assert protected_response.status_code == 400  # Verify access is granted
    
    response = protected_response.get_json()
    assert response['msg'] == "Message too long"