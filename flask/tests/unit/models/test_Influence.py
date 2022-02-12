from project.models import Influence, Influence_rank
import json
from project import  db
from datetime import datetime

def test_add_influence(test_app, new_structure_and_user):
    """Ensure a new role can be added to the database."""
    new_user, department, division, division2, div_role, div_role2, user2 = new_structure_and_user
    
    new_user.add_influence(50, division)
    new_user.add_influence(70, department)

    assert new_user.influence(division) == 50
    assert new_user.influence(department) == 70
    assert new_user.influence() == 120
    assert new_user.lifetime_influence() == 120
    assert new_user.lifetime_influence(department) == 120
    assert new_user.lifetime_influence(division) == 50


def test_influence_rank(test_app, new_structure_and_user):
    new_user, department, division, division2, div_role, div_role2, user2 = new_structure_and_user

    assert new_user.rank.title == "Corporateer"

def test_property(test_app, new_structure_and_user):
    """Ensure a new role can be added to the database."""
    new_user, department, division, division2, div_role, div_role2, user2 = new_structure_and_user

    new_user.update_tribute()
    assert new_user.tribute == 0

    old_date = datetime(2020, 1, 23)

    new_user.last_payment = old_date
    new_user.update_tribute()
    assert new_user.tribute == 75



def test_send_tribute(test_app, new_structure_and_user):
    new_user, department, division, division2, div_role, div_role2, user2 = new_structure_and_user

    new_user.tribute = 50

    new_user.send_tribute(user2, 30)
    assert new_user.influence() == 30
    assert new_user.lifetime_influence() == 30
    assert user2.influence() == 30
    assert new_user.lifetime_influence() == 30

