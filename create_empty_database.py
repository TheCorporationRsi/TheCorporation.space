from corporation import db 
from corporation import create_app
from corporation.config import Config
answer = input("Do you really want to create a new database (yes/no): ") 
if answer == "yes": 
    app = create_app()
    app.app_context().push()
    with app.app_context(): db.create_all()

else: 
    print('No database created')
/