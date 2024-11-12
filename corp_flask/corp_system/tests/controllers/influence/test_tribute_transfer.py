from corp_system.controllers.influence_system_manager import InfluenceSystemManager
from corp_system.controllers.structure_manager import StructureManager

from corp_system.models import Influence, Inf_Tribute, Division

from corp_system import db

import pytest

def test_transfer_tribute_no_department(client, new_user, new_user2):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 100
    db.session.commit()
    
    with pytest.raises(ValueError, match="Receiver not a CORP member"):
        InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=150, message="banana")
        
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    with pytest.raises(ValueError, match="Sender does not have enough tribute"):
        InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=150, message="banana")
        
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=100, message="banana")    
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id).first()
    influence2 = Influence.query.filter_by(account_id=new_user2.inf_account.id).first()
    
    assert new_user.inf_account.tribute_amount == 0
    
    assert influence1 is not None
    assert influence2 is not None
    
    assert influence1.amount == 100
    assert influence2.amount == 100
    assert influence1.department is None
    assert influence2.department is None
    assert influence1.division is None
    assert influence2.division is None
    
    tribute_log1 = Inf_Tribute.query.filter_by(sender=new_user.inf_account).first()
    tribute_log2 = Inf_Tribute.query.filter_by(receiver=new_user2.inf_account).first()
    
    assert tribute_log1 is not None
    assert tribute_log2 is not None
    assert tribute_log1 == tribute_log2
    
    assert tribute_log1.amount == 100
    assert tribute_log1.message == "banana"
        
def test_transfer_tribute_no_same_divisions(client, new_user, new_user2, new_department):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 100
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    
    division = StructureManager.create_division(title="test_division", department=new_department)
    division2 = StructureManager.create_division(title="test_division2", department=new_department)
    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user2)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=100, message="banana")    
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id).first()
    influence2 = Influence.query.filter_by(account_id=new_user2.inf_account.id).first()
    
    assert new_user.inf_account.tribute_amount == 0
    
    assert influence1.amount == 100
    assert influence2.amount == 100
    assert influence1.department == new_department
    assert influence2.department == new_department
    assert influence1.division is None
    assert influence2.division is None
    
    tribute_log1 = Inf_Tribute.query.filter_by(sender=new_user.inf_account).first()
    tribute_log2 = Inf_Tribute.query.filter_by(receiver=new_user2.inf_account).first()
    
    assert tribute_log1 is not None
    assert tribute_log2 is not None
    assert tribute_log1 == tribute_log2
    
def test_transfer_tribute_with_divisions(client, new_user, new_user2, new_department):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 100
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    
    division = StructureManager.create_division(title="test_division", department=new_department)
    division2 = StructureManager.create_division(title="test_division2", department=new_department)
    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user2)
    division2.member_role.assign(new_user)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=100, message="banana")    
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id).first()
    influence2 = Influence.query.filter_by(account_id=new_user2.inf_account.id).first()
    
    assert new_user.inf_account.tribute_amount == 0
    
    assert influence1.amount == 100
    assert influence2.amount == 100
    assert influence1.department == new_department
    assert influence2.department == new_department
    assert influence1.division == division2
    assert influence2.division == division2


def test_transfer_tribute_2dep_1div(client, new_user, new_user2):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 100
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)

    
    division.member_role.assign(new_user)
    division.member_role.assign(new_user2)
    division2.member_role.assign(new_user)
    division3.member_role.assign(new_user2)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=100, message="banana")
    
    influences = Influence.query.all()
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id, department=department2).first()
    influence4 = Influence.query.filter_by(account_id=new_user2.inf_account.id, department=department2).first()
    influence2 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division).first()
    influence3 = Influence.query.filter_by(account_id=new_user2.inf_account.id, division=division).first()
    
    assert new_user.inf_account.tribute_amount == 0
    
    assert len(influences) == 4
    assert sum([influence.amount for influence in influences]) == 200
    assert influence1.amount == 50
    assert influence2.amount == 50
    assert influence3.amount == 50
    assert influence4.amount == 50
    
    assert influence1.department == department2
    assert influence2.department == department1
    assert influence3.department == department1
    assert influence4.department == department2
    assert influence1.division is None
    assert influence2.division == division
    assert influence3.division == division
    assert influence4.division is None

def test_transfer_tribute_weird_split(client, new_user, new_user2):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 100
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)
    division4 = StructureManager.create_division(title="test_division4", department=department1)

    
    division.member_role.assign(new_user)
    division4.member_role.assign(new_user2)
    
    division2.member_role.assign(new_user)
    division2.member_role.assign(new_user2)
    division3.member_role.assign(new_user2)
    division3.member_role.assign(new_user)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=100, message="banana")
    
    influences = Influence.query.all()
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id, department=department1).first()
    influence2 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division2).first()
    influence3 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division3).first()
    
    assert new_user.inf_account.tribute_amount == 0
    
    assert len(influences) == 6
    assert sum([influence.amount for influence in influences]) == 200
    assert influence1.amount == 34
    assert influence2.amount == 33
    assert influence3.amount == 33
    
    assert influence1.department == department1
    assert influence2.department == department2
    assert influence3.department == department2
    assert influence1.division is None
    assert influence2.division == division2
    assert influence3.division == division3
    
def test_transfer_tribute_weird_amount(client, new_user, new_user2):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 1
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)
    division4 = StructureManager.create_division(title="test_division4", department=department1)

    
    division.member_role.assign(new_user)
    division4.member_role.assign(new_user2)
    
    division2.member_role.assign(new_user)
    division2.member_role.assign(new_user2)
    division3.member_role.assign(new_user2)
    division3.member_role.assign(new_user)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=1, message="banana")
    
    influences = Influence.query.all()
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id, department=department1).first()
    influence2 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division2).first()
    influence3 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division3).first()
    assert new_user.inf_account.tribute_amount == 0
    
    assert len(influences) == 2
    assert sum([influence.amount for influence in influences]) == 2
    

def test_transfer_tribute_weird_amount2(client, new_user, new_user2):

    # Set the initial tribute amount for new_user
    new_user.inf_account.tribute_amount = 2
    db.session.commit()
    
    new_user2.CORP_confirmed = True
    db.session.commit()
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)
    division4 = StructureManager.create_division(title="test_division4", department=department1)

    
    division.member_role.assign(new_user)
    division4.member_role.assign(new_user2)
    
    division2.member_role.assign(new_user)
    division2.member_role.assign(new_user2)
    division3.member_role.assign(new_user2)
    division3.member_role.assign(new_user)
    
    InfluenceSystemManager.send_tribute(sender=new_user, receiver=new_user2, amount=2, message="banana")
    
    influences = Influence.query.all()
    
    influence1 = Influence.query.filter_by(account_id=new_user.inf_account.id, department=department1).first()
    influence2 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division2).first()
    influence3 = Influence.query.filter_by(account_id=new_user.inf_account.id, division=division3).first()
    
    assert new_user.inf_account.tribute_amount == 0
    assert len(influences) == 4
    assert sum([influence.amount for influence in influences]) == 4