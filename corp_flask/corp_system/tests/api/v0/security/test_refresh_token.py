from corp_system import db
from corp_system.models import User

def test_refresh_token(cyber_client, new_verified_user):
   
    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.post('/api/v0/refresh_token', headers={'X-CSRF-TOKEN': csrf_refresh_token})
    assert protected_response.status_code == 200  # Verify access is granted
    
    assert 'Set-Cookie' in protected_response.headers
    cookies = protected_response.headers.getlist('Set-Cookie')
    jwt_cookie = next((cookie for cookie in cookies if 'corp_access_pass=' in cookie), None)
    csrf_token = next((cookie for cookie in cookies if 'corp_access_pass_xeno_defense=' in cookie), None)
    jwt__refresh_cookie = next((cookie for cookie in cookies if 'corp_refresh_pass=' in cookie), None)
    csrf_refresh_token = next((cookie for cookie in cookies if 'corp_refresh_pass_xeno_defense=' in cookie), None)
    assert jwt_cookie
    assert csrf_token
    assert jwt__refresh_cookie is None
    assert csrf_refresh_token is None
    
    
def test_disconnect(cyber_client):
   
    client, csrf_token, csrf_refresh_token = cyber_client
    
    user = User.query.filter_by(RSI_handle='Cyber-Dreamer').first()
    
    #protected_response = client.post('/api/refresh_token', headers={'X-CSRF-TOKEN': csrf_refresh_token})
    #assert protected_response.status_code == 200  # Verify access is granted
    
    protected_response = client.post('/api/v0/refresh_token', headers={'X-CSRF-TOKEN': csrf_refresh_token})
    assert protected_response.status_code == 200  # Verify access is granted
    
    token = user.auth_tokens[0]
    user.disconnect()
    
    
    protected_response = client.post('/api/v0/refresh_token', headers={'X-CSRF-TOKEN': csrf_refresh_token})
    assert protected_response.status_code == 401  # Verify access is granted