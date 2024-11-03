from corp_system.models import Influence

from corp_system import db



def test_influence_model(client, new_user, new_department, new_division):
    # Create a department
    influence = Influence(account_id=new_user.inf_account.id, amount=100, department=new_department)
    influence2 = Influence(account_id=new_user.inf_account.id, amount=100, department=new_department, division=new_division)
    db.session.add(influence)
    db.session.add(influence2)
    db.session.commit()

    # Assert that the retrieved department matches the created department
    account = new_user.inf_account
    assert Influence.query.filter_by(account_id=new_user.inf_account.id).first() is not None
    assert account is not None
    assert influence.account == account
    assert influence.department_influence == True
    assert influence.division_influence == False
    assert influence2.account == account
    assert influence2.department_influence == True
    assert influence2.division_influence == True

    
    assert influence.amount == 100
    assert influence.initial_amount == 100
    
    assert account.current_influence() == 200
    assert account.current_influence(division=new_division) == 100
    assert account.current_influence(department=new_department) == 200
    assert account.lifetime_influence() == 200
    assert account.lifetime_influence(division=new_division) == 100
    assert account.lifetime_influence(department=new_department) == 200


def test_influence_add(client, new_user, new_department):
    # Create a department
    new_user.inf_account.add_influence(amount=100, department=new_department)
    
    assert Influence.query.filter_by(account_id=new_user.inf_account.id).first() is not None
    assert new_user.inf_account is not None
    assert new_user.inf_account.current_influence() == 100
    assert new_user.inf_account.current_influence(department=new_department) == 100
    assert new_user.inf_account.lifetime_influence() == 100
    assert new_user.inf_account.lifetime_influence(department=new_department) == 100