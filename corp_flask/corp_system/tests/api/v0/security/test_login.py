from corp_system import db


def test_login_fail(client, new_verified_user):
    new_verified_user.Enabled_2FA = False
    db.session.commit()
    
    rv = client.post('/api/v0/login', json={'username': 'Banana', 'password': 'Test_password123!'}, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 400
    

def test_login(client, new_verified_user):
    new_verified_user.Enabled_2FA = False
    db.session.commit()
    
    rv = client.post('/api/v0/login', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!'}, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 200
    
    # Check if the Set-Cookie header is present
    assert 'Set-Cookie' in rv.headers
    cookies = rv.headers.getlist('Set-Cookie')
    jwt_cookie = next((cookie for cookie in cookies if 'corp_access_pass=' in cookie), None)
    csrf_token = next((cookie for cookie in cookies if 'corp_access_pass_xeno_defense=' in cookie), None)
    jwt__refresh_cookie = next((cookie for cookie in cookies if 'corp_refresh_pass=' in cookie), None)
    csrf_refresh_token = next((cookie for cookie in cookies if 'corp_refresh_pass_xeno_defense=' in cookie), None)
    assert jwt_cookie
    assert csrf_token
    assert jwt__refresh_cookie
    assert csrf_refresh_token

    
    protected_response = client.get('/api/v0/protected')
    assert protected_response.status_code == 200  # Verify access is granted
    
    
    
    protected_response = client.post('/api/v0/protected')
    assert protected_response.status_code == 401
    
    csrf_token = next((cookie.split('=')[1].split(';')[0] for cookie in cookies if 'corp_access_pass_xeno_defense=' in cookie), None)
    
    protected_response = client.post('/api/v0/protected', headers={'X-CSRF-TOKEN': csrf_token})
    assert protected_response.status_code == 200  # Verify access is granted
    
def test_login_with_otp(client, new_verified_user):
    
    rv = client.post('/api/v0/login', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!', "otp":new_verified_user.generate_otp()}, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 200
    
    assert 'Set-Cookie' in rv.headers
    cookies = rv.headers.getlist('Set-Cookie')
    jwt_cookie = next((cookie for cookie in cookies if 'corp_access_pass=' in cookie), None)
    csrf_token = next((cookie for cookie in cookies if 'corp_access_pass_xeno_defense=' in cookie), None)
    jwt__refresh_cookie = next((cookie for cookie in cookies if 'corp_refresh_pass=' in cookie), None)
    csrf_refresh_token = next((cookie for cookie in cookies if 'corp_refresh_pass_xeno_defense=' in cookie), None)
    assert jwt_cookie
    assert csrf_token
    assert jwt__refresh_cookie
    assert csrf_refresh_token

    
    protected_response = client.get('/api/v0/protected')
    assert protected_response.status_code == 200  # Verify access is granted

def test_cyber_client(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    protected_response = client.get('/api/v0/protected')
    assert protected_response.status_code == 200  # Verify access is granted
    
    protected_response = client.post('/api/v0/protected')
    assert protected_response.status_code == 401
    
    protected_response = client.post('/api/v0/protected', headers={'X-CSRF-TOKEN': csrf_token})
    assert protected_response.status_code == 200  # Verify access is granted