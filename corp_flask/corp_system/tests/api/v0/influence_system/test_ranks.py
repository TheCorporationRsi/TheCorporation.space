from corp_system.models import User, Inf_Rank
import json

def test_ranks(cyber_client):

    client, csrf_token, csrf_refresh_token = cyber_client
    
    user: User = User.query.filter_by(RSI_handle="Cyber-Dreamer").first()
    user.CORP_confirmed = True
    
    rank = Inf_Rank.query.first()

    protected_response = client.get('/api/v0/influence_system/ranks')
    assert protected_response.status_code == 200  # Verify access is granted
    ranks = protected_response.get_json()
    assert ranks[0]['title'] == rank.title
    assert ranks[0]['required_lifetime_influence'] == rank.required_lifetime_influence
    assert ranks[0]['weekly_amount'] == rank.weekly_amount