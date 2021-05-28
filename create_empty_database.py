from corporation import db 
from corporation import create_app
from corporation.config import Config
from corporation.models import User, Role

answer = input("Do you really want to create a new database (yes/no): ") 
if answer == "yes": 
    app = create_app()
    app.app_context().push()
    with app.app_context(): 
        db.create_all()
        role = Role.query.filter_by(title="Corporateer").first()
        if not role:
            corporateer = Role(title="Corporateer", created_by="Cyber-Dreamer", discord_id= None, color= "blue")
            db.session.add(corporateer)
            db.session.commit()

else: 
    print('No database created')