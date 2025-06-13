from datetime import datetime
from corp_system import db
from corp_system.models import Base

class CommodityType(Base):
    __tablename__ = 'commodities'

    title = db.Column(db.String(128), nullable=False, unique=True)
    description = db.Column(db.String(512))
    
    is_gem = db.Column(db.Boolean, nullable=False, default=False)
    available_raw = db.Column(db.Boolean, nullable=False, default=False)
    is_salvageable = db.Column(db.Boolean, nullable=False, default=False)
    
    

    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
        }

    def __repr__(self):
        return f"Commodity('{self.name}', '{self.price}', '{self.description}')"
