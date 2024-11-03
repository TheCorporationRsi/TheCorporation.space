from corp_system.models import Inf_Tribute

from corp_system import db



def test_Inf_transaction_model(client, new_user, new_user2):
    # Create a department
    account = Inf_Tribute(
        sender=new_user.inf_account, 
        sender_influence = new_user.inf_account.get_weight_dict(),
        receiver=new_user2.inf_account, 
        receiver_influence = new_user2.inf_account.get_weight_dict(),
        amount=100,
        method="test",
        message="I love banana!"
    )
    db.session.add(account)
    db.session.commit()

    # Assert that the retrieved department matches the created department
    tribute = Inf_Tribute.query.filter_by(sender=new_user.inf_account, receiver=new_user2.inf_account).first()
    assert tribute is not None
    assert tribute.sender == new_user.inf_account
    assert tribute.receiver == new_user2.inf_account
    assert tribute.amount == 100
    assert tribute.method == "test"
    assert tribute.message == "I love banana!"
    assert tribute.sender_influence == new_user.inf_account.get_weight_dict()
    assert tribute.receiver_influence == new_user2.inf_account.get_weight_dict()
    
    