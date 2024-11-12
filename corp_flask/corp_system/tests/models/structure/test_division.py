from corp_system.models import Division, Department, Role
from corp_system import db

def test_division_model(client, new_department):
    # Create a department
    division = Division(title='Engineering', department=new_department)
    db.session.add(division)
    db.session.commit()

    # Assert that the retrieved department matches the created department
    assert Division.query.filter_by(title='Engineering').first() is not None
    assert division.department == new_department
    assert division.title == 'Engineering'
    assert division.leader_role is not None
    assert division.proxy_role is not None
    assert division.member_role is not None
    assert division.leader_role.division == division
    assert division.proxy_role.division == division
    assert division.member_role.division == division
    assert division.members == []
    assert division.roles == [division.leader_role, division.proxy_role, division.member_role]

def test_add_division(client, new_department):
    
    new_department.add_division('Tuff_guys')
    
    assert new_department.divisions[0].title == 'Tuff_guys'

def test_division_deletion(client, new_department):
    division = Division(title='Engineering', department_id=new_department.id)
    db.session.add(division)
    db.session.commit()
    
    
    division.delete()
    
    assert Department.query.filter_by(title='test_department').first() is not None
    assert Division.query.first() is None
    assert Role.query.first() is not None