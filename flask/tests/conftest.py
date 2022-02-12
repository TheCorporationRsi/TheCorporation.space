from typing_extensions import Required
import pytest
import jwt
from project.models import User, Role, Department, Division, Influence, Influence_rank

import os
import shutil

from project import create_app, db
from project.config import Config

@pytest.fixture(scope='module')
def test_app(app):
    with app.test_client() as testing_client:
        yield testing_client  

@pytest.fixture(scope='session')
def app():
    app = create_app(Config.TestingConfig)
    with app.app_context():   
        db.create_all()
        
        yield app  
        db.session.remove()  # looks like db.session.close() would work as well
        db.drop_all()

        os.system('pyclean .')
        

@pytest.fixture(scope='function')
def new_user():
    user = User(RSI_handle= "test", email="lol@hotmail.com", password="test123456")
    db.session.add(user)
    db.session.commit()

    yield user

    db.session.delete(user)
    db.session.commit()

@pytest.fixture(scope='function')
def new_role():
    role = Role(title= "test", type="lol" )
    db.session.add(role)
    db.session.commit()

    yield role

    db.session.delete(role)
    db.session.commit()


@pytest.fixture(scope='function')
def new_structure_and_user():
    user = User(RSI_handle= "test", email="lol@hotmail.com", password="test123456")
    db.session.add(user)
    department = Department(title= "new_department")
    db.session.add(department)
    division = Division(title= "new_division", department=department )
    db.session.add(division)
    division2 = Division(title= "new_division2", department=department )
    db.session.add(division2)
    div_role = Role.query.filter_by(title="new_division Member").first()
    div_role2 = Role.query.filter_by(title="new_division2 Member").first()

    user2 = User(RSI_handle= "test2", email="lol2@hotmail.com", password="test1234567")
    db.session.add(user2)
    db.session.commit()

    user.add_role(div_role)
    user.add_role(div_role2)

    user2.add_role(div_role)
    user2.add_role(div_role2)

    yield user, department, division, division2, div_role, div_role2, user2

    db.session.delete(user)
    db.session.delete(user2)
    db.session.delete(department)
    
    db.session.commit()