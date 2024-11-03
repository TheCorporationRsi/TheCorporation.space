

    
def test_protected_page(client):
    rv = client.get('/api/v0/protected')
    assert rv.status_code == 401