from corp_system.models import Role
from corp_system import db

def test_role_creation(client):
    role = Role(title="test_role")
    
    db.session.add(role)
    db.session.commit()

    assert Role.query.filter_by(title='test_role').first() is not None
    assert role.title == "test_role"
    assert role.color == "grey"
    assert role.type == "Unlinked ROLE"
    assert role.department is None
    assert role.division is None
    assert role.users == []
    assert role.discord_id is None
    
def test_role_user_assignment(client, new_role, new_user):
    new_role.users.append(new_user)
    db.session.commit()
    
    assert new_role.users == [new_user]
    assert new_role.users[0].RSI_handle == 'Cyber-Dreamer'
    assert new_user.roles == [new_role]
    
def test_user_role_assignment(client, new_role, new_user):
    new_user.add_role(new_role)
    db.session.commit()
    
    assert new_user.roles == [new_role]
    assert new_user.roles[0].color == "grey"
    assert new_role.users == [new_user]