from project.models import Role, Division, Department
import json
from project import  db

def test_add_role(test_app):
    """Ensure a new role can be added to the database."""

    role = Role(title= "added_role", type="lol" )
    db.session.add(role)
    db.session.commit()

    assert Role.query.filter_by(title="added_role").first() == role

def test_add_department(test_app):
    
    department = Department(title= "added_department")
    db.session.add(department)
    db.session.commit()


    dep_test = department.query.filter_by(title="added_department").first()
    dep_leader = Role.query.filter_by(title="added_department Head").first()
    dep_proxy = Role.query.filter_by(title="added_department Proxy").first()

    assert dep_test == department
    assert dep_leader.type == 'Dep_Head'
    assert dep_leader.department == dep_test
    assert dep_proxy.type == 'Dep_Proxy'
    assert dep_proxy.department == dep_test

    assert Department.query.filter_by(title="added_department").first() == department

def test_add_division(test_app):

    department = Department(title= "department_test")
    db.session.add(department)
    
    division = Division(title= "added_division", department=department )
    db.session.add(division)
    db.session.commit()

    div_test = Division.query.filter_by(title="added_division").first()
    div_role = Role.query.filter_by(title="added_division Member").first()
    div_leader = Role.query.filter_by(title="added_division Leader").first()
    div_proxy = Role.query.filter_by(title="added_division Proxy").first()

    assert div_test == division
    assert div_test.department == department
    assert div_test.department_id == department.id
    assert div_role.type == 'Member'
    assert div_role.department == div_test.department
    assert div_role.division == div_test
    assert div_leader.type == 'Div_Leader'
    assert div_leader.department == div_test.department
    assert div_leader.division == div_test
    assert div_proxy.type == 'Div_Proxy'
    assert div_proxy.department == div_test.department
    assert div_proxy.division == div_test

    db.session.delete(department)
    db.session.commit()

    div_test = Division.query.filter_by(title="added_division").first()
    div_role = Role.query.filter_by(title="added_division Member").first()
    div_leader = Role.query.filter_by(title="added_division Leader").first()
    div_proxy = Role.query.filter_by(title="added_division Proxy").first()

    assert div_test is None
    assert div_role is None
    assert div_leader is None
    assert div_proxy is None





def test_user_add_role(test_app, new_user, new_role):
    new_user.add_role(new_role)
    assert new_role in new_user.roles

def test_user_has_role(test_app, new_user, new_role):
    new_user.add_role(new_role)
    assert new_user.has_role(new_role)

def test_user_remove_role(test_app, new_user, new_role):
    new_user.add_role(new_role)
    new_user.remove_role(new_role)
    assert new_user.has_role(new_role) is False

def test_property(test_app, new_structure_and_user):
    new_user, department, division, division2, div_role, div_role2, user2 = new_structure_and_user

    assert new_user.is_member(department)
    assert new_user.is_member(division)
    assert new_user.has_role(div_role)

    assert new_user.get_weight(div_role) == 0
    assert new_user.get_weight(department) == 0
    assert new_user.get_weight(division) == 0
    new_user.set_weight(div_role, 20)
    assert new_user.get_weight(div_role) == 20
    assert new_user.get_weight(department) == 20
    assert new_user.get_weight(division) == 20
    new_user.set_weight(div_role2, 30)
    assert new_user.get_weight(div_role2) == 30
    assert new_user.get_weight(department) == 50
    assert new_user.get_weight(division) == 20
    assert new_user.get_weight(division2) == 30
    new_user.set_weight(division2, 40)
    assert new_user.get_weight(div_role2) == 40


