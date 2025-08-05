import pytest
from corp_system.tools.scraping.rsi_account import RSI_account
from corp_system.tools.scraping.funding import RSI_funding
from corp_system import db
from corp_system.models import User, Role, Department, Division, Inf_Rank
from corp_system.controllers.security_manager import SecurityManager

import os

@pytest.fixture
def RSI_website_account():
    return RSI_account("cyber-dreamer")


@pytest.fixture
def RSI_website_funding():
    return RSI_funding()

@pytest.fixture
def new_user():
    RSI_handle = 'Cyber-Dreamer'
    password = 'Test_password123!'
    SecurityManager.register_user(RSI_handle, password)
    user : User = User.query.filter_by(RSI_handle=RSI_handle).first()
    user.Enabled_2FA = True
    yield user
    
    user.delete()

@pytest.fixture
def new_user2():
    RSI_handle = 'Cyber-Dreamer2'
    password = 'Test_password123!'
    SecurityManager.register_user(RSI_handle, password)
    user : User = User.query.filter_by(RSI_handle=RSI_handle).first()
    user.Enabled_2FA = True
    yield user
    
    user.delete()

@pytest.fixture
def new_verified_user(new_user: User):
    new_user.RSI_confirmed = True
    yield new_user
    
@pytest.fixture
def new_role():
    role = Role(title="test_role")
    
    db.session.add(role)
    db.session.commit()

    yield role

    role.delete()

@pytest.fixture
def new_department():
    department = Department(title="test_department")
    
    db.session.add(department)
    db.session.commit()

    yield department

    department.delete()

@pytest.fixture
def new_division(new_department):
    division = Division(title="test_division", department_id=new_department.id)
    
    db.session.add(division)
    db.session.commit()

    yield division

    division.delete()
    
@pytest.fixture
def new_rank():
    rank = Inf_Rank(title='Rank1', required_lifetime_influence=50, weekly_amount=75)
    db.session.add(rank)
    db.session.commit()

    yield rank

    rank.delete()
    
@pytest.fixture
def cyber_client(client, new_verified_user):
    rv = client.post('/api/v0/login', json={'username': 'Cyber-Dreamer', 'password': 'Test_password123!', "otp":new_verified_user.generate_otp()}, environ_base={'wsgi.url_scheme': 'https'})
    assert rv.status_code == 200
    
    assert 'Set-Cookie' in rv.headers
    cookies = rv.headers.getlist('Set-Cookie')
    
    csrf_token = next((cookie.split('=')[1].split(';')[0] for cookie in cookies if 'corp_access_pass_xeno_defense=' in cookie), None)
    csrf_refresh_token = next((cookie.split('=')[1].split(';')[0] for cookie in cookies if 'corp_refresh_pass_xeno_defense=' in cookie), None)
    
    yield client, csrf_token, csrf_refresh_token

@pytest.fixture
def client():
    from app import app
    app.config['TESTING'] = True
    with app.test_client() as client:
        with app.app_context():
            
            db.create_all()
            from corp_system.models import Role, Inf_Rank
        
            if Role.query.filter_by(title='Corporateer').first() is None:
                db.session.add(Role(title='Corporateer'))
                db.session.commit()
            
            if Inf_Rank.query.filter_by(title='Intern').first() is None:
                db.session.add(Inf_Rank(title='Intern',  required_lifetime_influence=0, weekly_amount=50))
                db.session.commit()
                
            yield client
            
            db.session.remove()
            db.drop_all()
            
            
@pytest.fixture
def request_context():
    from app import app
    app.config['TESTING'] = True
    with app.test_client():
        with app.app_context():
            db.create_all()
            from corp_system.models import Role, Inf_Rank
            
        
            if Role.query.filter_by(title='Corporateer').first() is None:
                db.session.add(Role(title='Corporateer'))
                db.session.commit()
            
            if Inf_Rank.query.filter_by(title='Intern').first() is None:
                db.session.add(Inf_Rank(title='Intern',  required_lifetime_influence=0, weekly_amount=50))
                db.session.commit()
                
            with app.test_request_context() as context:
                yield context
            db.session.remove()
            db.drop_all()


@pytest.fixture(scope='session', autouse=True)
def cleanup():
    yield
    os.system('pyclean ..')