from corp_system.models import Department, Division, Role
from corp_system import db

def test_department_model(client):
    # Create a department
    department = Department(title='Engineering')
    db.session.add(department)
    db.session.commit()

    # Assert that the retrieved department matches the created department
    assert Department.query.filter_by(title='Engineering').first() is not None
    assert department.title == 'Engineering'
    assert department.head_role is not None
    assert department.proxy_role is not None
    assert department.head_role.department == department
    assert department.proxy_role.department == department
    assert department.divisions == []
    assert department.roles == [department.head_role, department.proxy_role]
    
def test_department_deletion(client):
    department = Department(title='Engineering')
    db.session.add(department)
    db.session.commit()
    
    department.add_division('Tuff_guys')
    department
    
    department.delete()
    
    assert Department.query.filter_by(title='Engineering').first() is None
    assert Division.query.first() is None
    assert Role.query.filter_by(title='Engineering Head').first() is None