from corp_system.models import Inf_Account

from corp_system import db



def test_Inf_Account_model(client):
    # Create a department
    account = Inf_Account()
    db.session.add(account)
    db.session.commit()

    # Assert that the retrieved department matches the created department
    account = Inf_Account.query.first()
    assert account is not None
    assert account.tribute_amount == 0
    assert account.user is None
    assert account.rank.title == 'Corporateer'
    assert account.rank.accounts == [account]

def test_Inf_Account_creation(client, new_user):
    # Create a department

    # Assert that the retrieved department matches the created department
    account = Inf_Account.query.filter_by(user_id=new_user.id).first()
    assert account is not None
    assert new_user.inf_account is not None
    assert new_user.inf_account == account


    