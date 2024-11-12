from corp_system import db
from sqlalchemy.orm import backref
from .. import Base


class Influence(Base):
    __tablename__ = "influence"

    # Account
    account_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=False)
    account = db.relationship("Inf_Account", backref='influences', foreign_keys=[account_id], lazy=True)
    
    # Department
    department_id = db.Column(db.String(36), db.ForeignKey('department.id'), nullable=True)
    department = db.relationship("Department", foreign_keys=[department_id], lazy=True)
    department_influence = db.Column(db.Boolean, default=False)
    
    # Division
    division_id = db.Column(db.String(36), db.ForeignKey('division.id'), nullable=True)
    division = db.relationship("Division", foreign_keys=[division_id], lazy=True)
    division_influence = db.Column(db.Boolean, default=False)
    
    # Amount
    amount = db.Column(db.Integer, default=0)
    initial_amount = db.Column(db.Integer, default=0)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        self.initial_amount = self.amount
        
        if self.division:
            self.department = self.division.department
            self.division_influence = True
            self.department_influence = True
            
        elif self.department:
            self.department_influence = True
        
        db.session.commit()
    
    def delete(self):
        db.session.delete(self)
        db.session.commit()

    def __repr__(self):
        return f"Influence(amount:'{self.amount}', department:'{self.department}', division:'{self.division}')"
    
    def as_dict(self): 
        return {
            'account': self.account.as_dict(),
            'department': self.department.as_dict() if self.department else None,
            'department_influence': self.department_influence,
            'was_department_influence': self.was_department_influence,
            'division': self.division.as_dict() if self.division else None,
            'division_influence': self.division_influence,
            'was_division_influence': self.was_division_influence,
            'amount': self.amount,
            'initial_amount': self.initial_amount,
        }
