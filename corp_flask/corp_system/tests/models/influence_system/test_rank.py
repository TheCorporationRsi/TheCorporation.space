from corp_system.models import Inf_Rank
from corp_system import db


def test_rank_creation(client):
    # Create a rank
    rank = Inf_Rank(title='Rank1', required_lifetime_influence=100, weekly_amount=50)
    db.session.add(rank)
    db.session.commit()

    # Assert that the retrieved rank matches the created rank
    assert Inf_Rank.query.filter_by(title='Rank1').first() is not None
    assert Inf_Rank.query.filter_by(title='Corporateer').first() is not None
    assert rank.title == 'Rank1'
    assert rank.required_lifetime_influence == 100
    assert rank.weekly_amount == 50
    assert rank.accounts == []

def test_rank_creation(client, new_rank, new_verified_user):
    pass