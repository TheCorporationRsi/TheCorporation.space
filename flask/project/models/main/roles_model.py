from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from sqlalchemy.orm import backref
from project import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash, session
from sqlalchemy import or_
from project.models import Base

import uuid
from sqlalchemy.dialects.postgresql import UUID


    
class Department(Base):
    __tablename__ = "department"
    
    title = db.Column(db.String(32), unique=True, nullable=False)
    color = db.Column(db.String(32), unique=False, nullable=True)
    
    image_file_1 = db.Column(db.String(20), nullable=False, default='default.jpg')
    image_file_2 = db.Column(db.String(20), nullable=False, default='default.jpg')
    image_file_3 = db.Column(db.String(20), nullable=False, default='default.jpg')
    image_file_4 = db.Column(db.String(20), nullable=False, default='default.jpg')
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        leader_role = Role(title= self.title + " Head", department = self, color= self.color, type="Dep_Head")
        proxy_role = Role(title= self.title + " Proxy", department = self, color= self.color, type="Dep_Proxy")
        
        db.session.add(leader_role)
        db.session.add(proxy_role)
        
    def update(self):
        for division in self.divisions:
            division.update()
        
        for role in self.roles:
            role.update()
    
    @property
    def members(self):
        users = []
        for role in self.roles:
            for member in role.members:
                if member not in users:
                    users.append(member)
        return users
    
    def has_member(self, member):
        return True if member in self.members else False
            
    
    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'color': self.color,
            'divisions' : [division.as_dict() for division in self.divisions]
        }

    def __repr__(self):
        return f"Department('{self.title}')"



class Division(Base):
    __tablename__ = "division"
    
    title = db.Column(db.String(32), unique=True, nullable=False)

    department_id = db.Column(db.Text(length=36), db.ForeignKey('department.id'), nullable=False)
    department = db.relationship(Department, backref=db.backref("divisions", cascade="all, delete"), foreign_keys=[department_id], lazy=True)
    
    logo = db.Column(db.String(20), nullable=False, default='default.png')
    motto = db.Column(db.String(200), nullable=False, default='Empty')
    
    color = db.Column(db.String(32), db.ForeignKey('department.color'), unique=False, nullable=True)
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        member_role = Role(title= f"{self.title} Member", division = self, department = self.department, color= self.department.color, type="Member")
        leader_role = Role(title= f"{self.title} Leader", division = self, department = self.department, color= self.department.color, type="Div_Leader")
        proxy_role = Role(title= f"{self.title} Proxy", division = self, department = self.department, color= self.department.color, type="Div_Proxy")

        db.session.add(member_role)
        db.session.add(leader_role)
        db.session.add(proxy_role)

    
    @property
    def members(self):
        users = []
        for role in self.roles:
            for member in role.members:
                if member not in users:
                    users.append(member)
        return users
    
    def update(self):
        
        self.color = self.department.color
        for role in self.roles:
            role.update()
            
        db.session.commit()
    
        
    
    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'color': self.color
        }

    def __repr__(self):
        return f"Division('{self.title}')"
    

class Role(Base):
    __tablename__ = "role"
    
    title = db.Column(db.String(32), unique=True, nullable=False)

    division_id = db.Column(db.Text(length=36), db.ForeignKey('division.id'), nullable=True)
    department_id = db.Column(db.Text(length=36), db.ForeignKey('department.id'), nullable=True)
    
    division = db.relationship(Division, backref=db.backref("roles", cascade="all, delete"), foreign_keys=[division_id], lazy=True)
    department = db.relationship(Department, backref=db.backref("roles", cascade="all, delete"), foreign_keys=[department_id], lazy=True)

    color = db.Column(db.String(32), unique=False, nullable=True, default='grey')
    type = db.Column(db.String(32), unique=False, nullable=True)

    discord_id = db.Column(db.Integer, unique=True, nullable=True)
    guilded_id = db.Column(db.Integer, unique=True, nullable=True)
    
    
    def update(self):
        
        if self.type == "Dep_Head":
            self.title = f"{self.department.title} Head"
            self.color = self.department.color
        elif self.type == "Dep_Proxy":
            self.title = f"{self.department.title} Proxy"
            self.color = self.department.color
        elif self.type == "Div_Head":
            self.title = f"{self.division.title} Leader"
            self.color = self.department.color
        elif self.type == "Div_Proxy":
            self.title = f"{self.division.title} Proxy"
            self.color = self.department.color
        elif self.type == "Member":
            self.title = f"{self.division.title} Member"
            self.color = self.department.color
            
        db.session.commit()


    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'type': self.type
        }

    def __repr__(self):
        return f"Role('{self.title}', '{self.type}', '{self.division_id}', '{self.department_id}')"
