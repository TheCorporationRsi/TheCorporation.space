from project import db
from flask_login import current_user
import uuid
from sqlalchemy.dialects.postgresql import UUID

class Base(db.Model):
    __abstract__ = True

    id = db.Column(db.Text(length=36), unique=True, default=lambda: str(uuid.uuid4()), primary_key= True)
    created_on = db.Column(db.DateTime, default=db.func.now())
    created_by = db.Column(db.String(32), nullable=True, default= current_user.RSI_handle if current_user else None)
    updated_on = db.Column(db.DateTime, default=db.func.now(), onupdate=db.func.now())



from project.models.main.influence_model import *
from project.models.main.roles_model import *
from project.models.main.user_model import *
from project.models.stats.sc_stats_model import *
