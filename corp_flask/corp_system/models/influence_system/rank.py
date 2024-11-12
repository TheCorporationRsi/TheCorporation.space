from corp_system import db

from .. import Base




class Inf_Rank(Base):
    __tablename__ = "inf_rank"

    title = db.Column(db.String(32), unique=True, nullable=False)
    
    # Required Influence
    required_lifetime_influence = db.Column(db.Integer, unique=True, nullable=False, default=0)
    
    # Tribute amount
    weekly_amount = db.Column(db.Integer, unique=True, nullable=False, default=50)
    
    # Inf_Rank.members
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def __repr__(self):
        return f"Rank('{self.title}', '{self.date_added}')"
    
    def delete(self):
        db.session.delete(self)
        db.session.commit()
        
        for account in self.accounts:
            account.update()
    
    def as_dict(self):
        return {
            'title': self.title,
            'required_influence': self.required_influence,
            'weekly_amount': self.weekly_amount,
            'members': [member.as_dict() for member in self.members]
        }
