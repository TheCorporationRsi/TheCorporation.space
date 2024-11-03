from corp_system.models import User, Inf_Rank
import json


def test_departements_not_auth(client):

    protected_response = client.get('/api/v0/structure/departments')
    assert protected_response.status_code == 200  # Verify access is granted
    
def test_departements_auth(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/structure/departments')
    assert protected_response.status_code == 200  # Verify access is granted
    

def test_divisions_not_auth(client):

    protected_response = client.get('/api/v0/structure/divisions')
    assert protected_response.status_code == 200  # Verify access is granted
    
def test_divisions_auth(cyber_client):
    
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/structure/divisions')
    assert protected_response.status_code == 200  # Verify access is granted
