from corp_system import db
from .. import Base
from sqlalchemy.ext.hybrid import hybrid_property


class Division(Base):
    __tablename__ = "division"
    
    title = db.Column(db.String(32), unique=True, nullable=False)
    _color = db.Column(db.String(32), unique=False, nullable=True)
    logo = db.Column(db.String(20), nullable=False, default='default.png')
    motto = db.Column(db.String(200), nullable=False, default='Empty')
    
    hidden = db.Column(db.Boolean, default=False)
    restricted = db.Column(db.Boolean, default=False)
    
    # Department
    department_id = db.Column(db.String(36), db.ForeignKey('department.id', ondelete="CASCADE", name='fk_division_department_id'), nullable=False)
    department = db.relationship("Department", foreign_keys=[department_id], uselist=False, lazy=True, overlaps="divisions")
    
    # Leader role
    leader_role_id = db.Column(db.String(36), db.ForeignKey('role.id'), nullable=True)
    leader_role = db.relationship("Role", foreign_keys=[leader_role_id], uselist=False, lazy=True)
    
    # Proxy role
    proxy_role_id = db.Column(db.String(36), db.ForeignKey('role.id'), nullable=True)
    proxy_role = db.relationship("Role", foreign_keys=[proxy_role_id], uselist=False, lazy=True)
    
    # Member Role
    member_role_id = db.Column(db.String(36), db.ForeignKey('role.id'), nullable=True)
    member_role = db.relationship("Role", foreign_keys=[member_role_id], uselist=False, lazy=True)
    
    roles = db.relationship("Role", cascade="all, delete-orphan", lazy=True, foreign_keys='Role.division_id', overlaps="division")
    
    # Security requirement
    security_requirement = db.Column(db.Integer, nullable=False, default=1)  # 1: Member 2: Security level 2 ....
    
    # Division.roles as backref
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        from corp_system.models import Role
        
        leader_role = Role(title=self.title + " Leader", division=self, department=self.department)
        proxy_role = Role(title=self.title + " Proxy", division=self, department=self.department)
        member_role = Role(title=self.title + " Member", division=self, department=self.department)
        
        db.session.add(leader_role)
        db.session.add(proxy_role)
        db.session.add(member_role)
        
        db.session.commit()
        
        self.leader_role = leader_role
        self.proxy_role = proxy_role
        self.member_role = member_role
        
        db.session.commit()
    
    def get_weight(self, user):
        from corp_system.models import UserRole
        
        link = UserRole.query.filter_by(user=user, role=self.member_role).first()
        if link:
            return link.weight
        else: 
            return 0
        
    def set_weight(self, user, weight, equalize=False):
        from corp_system.models import UserRole
        
        if weight == 0:
            raise ValueError("Weight cannot be 0")
        
        link = UserRole.query.filter_by(user=user, role=self.member_role).first()
        link.weight = weight
        db.session.commit()
        
        if equalize:
            from corp_system.controllers.structure_manager import StructureManager
            StructureManager.equalize_roles(user)
        
    def add_member(self, user):
        self.member_role.assign(user)
    
    def is_member(self, user):
        if self.member_role in user.roles:
            return True
        else:
            return False
        
    
    def delete(self):
        
        self.member_role_id = None
        self.proxy_role_id = None
        self.leader_role_id = None
        db.session.commit()
        
        for role in self.roles:
                role.delete()
        '''    
        from corp_system.models import Influence
        
        influences = Influence.query.filter_by(division=self).all()
        for influence in influences:
            influence.division_influence = False
        '''
    
        db.session.delete(self)
        db.session.commit()
    
    # ============================== Property and setters =============================
    
    @hybrid_property
    def color(self):
        if self.department:
            return self.department.color
        else:
            return self._color

    @color.setter
    def color_setter(self, color: str):
        self._color = color
        db.session.commit()
    
    # ============================== methods =============================
    
    def add_member(self, user):
        user.roles.append(self.member_role)
        db.session.commit()
    
    @property  
    def members(self):
        return self.member_role.users
    
    # ============================== dictionary =============================
    def as_dict(self):
        leaders = []
        proxies = []
        if self.leader_role:
            leaders = [user.as_dict() for user in self.leader_role.members]
        if self.proxy_role:
            proxies = [user.as_dict() for user in self.proxy_role.members]

        return {
            'id': self.id,
            'title': self.title,
            'color': self.color,
            'department': self.department.as_dict(),
            'leaders': leaders,
            'proxies': proxies
        }

    def __repr__(self):
        return f"Division('{self.title}')"
