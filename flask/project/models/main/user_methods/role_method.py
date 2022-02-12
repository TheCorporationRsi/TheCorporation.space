from project import db
from project.models import Base

class UserRole(Base):
    __tablename__ = "user_role"
    
    role_id =  db.Column(db.Integer, db.ForeignKey('role.id', ondelete="CASCADE"))
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete="CASCADE"))
    
    weight = db.Column(db.Integer, default=0)

class role_methods:

    def has_role(self, role):
        return True if role in self.roles else False

    def set_weight(self, entity, weight):
        match entity.__class__.__name__:
            case "Division":
                if self.is_member(entity):
                    for role in entity.roles:
                        if role.type == "Member":
                            self.set_weight(role, weight)
            case "Role":
                if self.has_role(entity) and entity.type == "Member":
                    UserRole.query.filter_by(user_id=self.id, role_id=entity.id).first().weight = weight

    def get_weight(self, entity):
        value = 0
        match entity.__class__.__name__:
            case "Department":
                if self.is_member(entity):
                    for role in entity.roles:
                        if self.has_role(role) and role.type == "Member":
                            value += self.get_weight(role)
            case "Division":
                if self.is_member(entity):
                    for role in entity.roles:
                        if role.type == "Member":
                            value += self.get_weight(role)
            case "Role":
                if self.has_role(entity) and entity.type == "Member":
                    return UserRole.query.filter_by(user_id=self.id, role_id=entity.id).first().weight
        return value

    def add_role(self, role):
        if not self.has_role(role):
            self.roles.append(role)
            db.session.commit()

    def remove_role(self, role):
        if self.has_role(role):
            self.roles.remove(role)
            db.session.commit()

    def is_member(self, entity):
        for role in entity.roles:
            if role.type == "Member" and self.has_role(role):
                return True
        return False

    def is_manager(self, manager_type=None, division=-1, department=-1):
        if self.security == 5:
            return True

        for role in self.roles:
            if manager_type and role.type == manager_type:
                return True
            elif department and role.type in ["Dep_Head", "Dep_Proxy"] and role.department == department:
                return True
            elif division and role.type in ["Div_Leader", "Div_Proxy", "Dep_Head", "Dep_Proxy"] and (role.division == division or role.department == division.department):
                return True
            elif role.type in ["Div_Leader", "Div_Proxy", "Dep_Head", "Dep_Proxy"]:
                return True
        return False
    
    def highest_rank(self):

        rank_types = ["Corporateer", "Div_Proxy", "Div_Leader", "Dep_Proxy", "Dep_Head"]
        highest_role = None
        if self.security == 5:
            return "admin"
        else:
            for role in self.roles:
                if role.type in rank_types:
                    if rank_types.index(role.type) > rank_types.index(highest_role):
                        highest_role = role
                        
        if highest_role:
            return highest_role
        else:
            return None
