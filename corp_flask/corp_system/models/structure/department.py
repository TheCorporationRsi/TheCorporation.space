from corp_system import db
from .. import Base
from sqlalchemy.ext.hybrid import hybrid_property


class Department(Base):
    __tablename__ = "department"
    
    title = db.Column(db.String(32), unique=True, nullable=False)
    logo = db.Column(db.String(64), nullable=False, default='error')
    color = db.Column(db.String(32), unique=False, nullable=True)
    motto = db.Column(db.String(200), nullable=False, default='Empty')
    description = db.Column(db.String(500), nullable=False, default='Empty')
    
    # Head role
    head_role_id = db.Column(db.String(36), db.ForeignKey('role.id'), nullable=True)
    head_role = db.relationship("Role", foreign_keys=[head_role_id], uselist=False, lazy=True)
    
    # Proxy Role
    proxy_role_id = db.Column(db.String(36), db.ForeignKey('role.id'), nullable=True)
    proxy_role = db.relationship("Role", foreign_keys=[proxy_role_id], uselist=False, lazy=True)
    
    divisions = db.relationship("Division", cascade="all, delete-orphan", lazy=True, overlaps="department")
    
    roles = db.relationship("Role", cascade="all, delete-orphan", lazy=True, foreign_keys='Role.department_id', overlaps="department")
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        from corp_system.models import Role
        
        head_role = Role(title=self.title + " Head", department=self)
        proxy_role = Role(title=self.title + " Proxy", department=self)
        
        db.session.add(head_role)
        db.session.add(proxy_role)
        
        db.session.commit()
        
        self.head_role = head_role
        self.proxy_role = proxy_role
    
    def is_member(self, user):
        for division in self.divisions:
            if division.is_member(user):
                return True
        return False
    
    def delete(self):
        
        for division in self.divisions:
            division.delete()
            
        self.proxy_role_id = None
        self.head_role_id = None
        
        db.session.commit()
            
        for role in self.roles:
            role.delete()
            
        
        from corp_system.models import Influence
        from corp_system.models import Inf_Auction
        
        influences = Influence.query.filter_by(department=self).all()
        for influence in influences:
            influence.department_influence = False
            influence.department = None
        
        auctions = Inf_Auction.query.filter_by(department=self).all()
        for auction in auctions:
            auction.department = None
            
        
        
        db.session.delete(self)
        db.session.commit()
    
    @property
    def members(self):
        members = []
        for division in self.divisions:
            for member in division.members:
                if member not in members:
                    members.append(member)
        return members
    
    
    def get_weight(self, user):
        return sum([division.get_weight(user) for division in self.divisions])

    def add_division(self, title):
        from corp_system.models import Division
        
        division = Division(title=title, department_id=self.id)
        db.session.add(division)
        db.session.commit()
        return division

    def as_dict(self):
        leaders = []
        proxies = []
        if self.head_role:
            leaders = [user.as_dict() for user in self.head_role.members]
        if self.proxy_role:
            proxies = [user.as_dict() for user in self.proxy_role.members]

        return {
            'id': self.id,
            'title': self.title,
            'color': self.color,
            'divisions': [division.as_dict() for division in self.divisions],
            'leaders': leaders,
            'proxies': proxies
        }

    def __repr__(self):
        return f"Department('{self.title}')"
