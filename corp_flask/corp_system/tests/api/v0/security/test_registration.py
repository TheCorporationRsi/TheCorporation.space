from corp_system import db


def test_registration_already_exist(client, new_user):
    
    rv = client.post('/api/v0/register', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!', 'confirmed_password':'Test_password123!' }, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 400
    assert rv.get_json()["msg"] == "User already exists"
    
def test_registration_password_too_short(client):
    
    rv = client.post('/api/v0/register', json={'username': 'Cyber-Dreamer', 'password': 'P_w122!', 'confirmed_password':'P_w122!' }, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 400
    assert rv.get_json()["msg"] == "Password must be between 8 and 32 characters long."
    
def test_registration_password_no_match(client):
    
    rv = client.post('/api/v0/register', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!', 'confirmed_password':'test_passwor' }, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 400
    assert rv.get_json()["msg"] == "Password don't match"

def test_registration_wrong_rsi_handle(client):
    
    rv = client.post('/api/v0/register', json={'username': 'Cyber-Dreamer46', 'password': 'Test_password123!', 'confirmed_password':'Test_password123!' }, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 400
    assert rv.get_json()["msg"] == "RSI handle doesn't exit"
    
    
    

def test_registration(client):
    
    rv = client.post('/api/v0/register', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!', 'confirmed_password':'Test_password123!'}, environ_base={'wsgi.url_scheme': 'https'})
    print("Status Code:", rv.status_code)
    try:
        print("Data:", rv.data)
    except Exception as e:
        print("Error parsing JSON response:", e)
        print("Raw Response:", rv.data.decode('utf-8'))
    assert rv.status_code == 200
    print(rv.get_json()["msg"])


