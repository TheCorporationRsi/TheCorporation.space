from corp_system import db
from .. import Base
from sqlalchemy.ext.hybrid import hybrid_property
from sqlalchemy.orm import backref


class UserRole(Base):
    __tablename__ = "user_role"
    
    role_id = db.Column(db.String(36), db.ForeignKey('role.id', ondelete="CASCADE"), primary_key=True)
    role = db.relationship("Role", foreign_keys=[role_id], lazy=True, overlaps="roles")
    
    user_id = db.Column(db.String(36), db.ForeignKey('user.id', ondelete="CASCADE"), primary_key=True)
    user = db.relationship("User", foreign_keys=[user_id], lazy=True, overlaps="users")
    
    weight = db.Column(db.Integer, default=1)
    
    def delete(self):
        
        db.session.delete(self)
        db.session.commit()


class Role(Base):
    __tablename__ = "role"
    
    title = db.Column(db.String(32), unique=True, nullable=False)
    _color = db.Column(db.String(32), unique=False, nullable=True, default='grey')
    _logo = db.Column(db.String(64), nullable=False, default='error')

    # Department
    department_id = db.Column(db.String(36), db.ForeignKey('department.id', ondelete="CASCADE", name='fk_role_department_id'), nullable=True)
    department = db.relationship("Department", foreign_keys=[department_id], uselist=False, lazy=True, overlaps="roles")
    
    # Division
    division_id = db.Column(db.String(36), db.ForeignKey('division.id', ondelete="CASCADE", name='fk_role_division_id'), nullable=True)
    division = db.relationship("Division", foreign_keys=[division_id], uselist=False, lazy=True, overlaps="roles")
    
    # Members
    users = db.relationship('User', secondary='user_role', back_populates='roles', lazy='select', overlaps="role")
    
    # App link
    discord_id = db.Column(db.String(32), unique=True, nullable=True)
    
    # Members
    # members = db.relationship('User', back_populates='roles', secondary="user_role", lazy=True)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        if self.division:
            self.department = self.division.department
            
    def assign(self, user):
        if self not in user.roles:
            link = UserRole(user=user, role=self)
            db.session.add(link)
            db.session.commit()
    
    def delete(self):
        
        if self.title == "Corporateer":
            raise ValueError("You cannot delete this role")
        
        links = UserRole.query.filter_by(role_id=self.id).all()
        for link in links:
            link.delete()
        
        db.session.delete(self)
        db.session.commit()
    
    @property
    def color(self):
        if self.division:
            return self.division.color
        elif self.department:
            return self.department.color
        else:
            return self._color

    @color.setter
    def color(self, color: str):
        self._color = color
        db.session.commit()
    
    @property
    def logo(self):
        if self.division:
            return self.division.logo
        elif self.department:
            return self.department.logo
        else:
            return self._logo

    @color.setter
    def logo(self, logo: str):
        self._logo = logo
        db.session.commit()
    
    
    @hybrid_property
    def type(self):
        if self.division:
            if self.division.leader_role == self:
                return 'LEADER'
            elif self.division.proxy_role == self:
                return 'DIV_PROXY'
            elif self.division.member_role == self:
                return 'MEMBER'
            else:
                return 'OTHER DIVISION ROLE'
        
        elif self.department:
            if self.department.head_role == self:
                return 'HEAD'
            elif self.department.proxy_role == self:
                return 'DEP_PROXY'
            else:
                return 'OTHER DEPARTMENT ROLE'
        else:
            return 'Unlinked ROLE'
            
    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'type': self.type,
            "discord_id": self.discord_id,
        }

    def __repr__(self):
        return f"Role('{self.title}', '{self.type}', '{self.division_id}', '{self.department_id}')"
