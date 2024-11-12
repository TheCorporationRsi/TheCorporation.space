from corp_system import db
from flask_jwt_extended import current_user
import uuid


class Base(db.Model):
    __abstract__ = True

    id = db.Column(db.String(36), unique=True, default=lambda: str(uuid.uuid4()), primary_key=True)
    created_on = db.Column(db.DateTime, default=db.func.now())
    created_by = db.Column(db.String(36), nullable=True, default=current_user.RSI_handle if current_user else None)
    updated_on = db.Column(db.DateTime, default=db.func.now(), onupdate=db.func.now())

from .user import User, Jwt_Blacklist
from .structure import Department, Division, Role, UserRole
from .influence_system import Influence, Inf_Account, Inf_Rank, Inf_Tribute, Inf_Auction
from .rsi_stats import Funding