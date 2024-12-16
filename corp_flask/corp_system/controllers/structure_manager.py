from corp_system.models import db, Department, Division, Role, User

import re
from sqlalchemy import func

class StructureManager:
    
    @staticmethod
    def equalize_roles(user):
        from corp_system.models import Division
        divisions = Division.query.all()
        member_divisions = [division for division in divisions if division.is_member(user)]
        
        if len(member_divisions) == 0:
            return
        
        weights = [division.get_weight(user) for division in member_divisions]
        total_weight = sum(weights)
        
        if total_weight == 0:
            weights = [round(100/len(member_divisions)) for weight in weights]
            total_weight = sum(weights)

        if total_weight != 100:
            weights = [round((weight / total_weight) * 100) for weight in weights]
            diff = sum(weights) - 100
            if diff != 0:
                max_index = weights.index(max(weights))
                weights[max_index] -= diff

        for division, weight in zip(member_divisions, weights):
            division.set_weight(user, weight)
            
        db.session.commit()
            
    @staticmethod
    def create_department(title):
        # Create a new department with the given name and leader
        
        if not re.match("^[a-zA-Z0-9-_]{2,32}$", title):
            raise ValueError("Title doesn't respect the format")
        
        department= Department.query.filter(func.lower(Department.title) == func.lower(title)).first()
        if department:
            raise ValueError("Department title already exist")
        
        department = Department(title=title)
        db.session.add(department)
        db.session.commit()
        
        return department
    
    @staticmethod
    def update_department(department: Department, new_title=None, new_color=None, new_motto=None, new_logo=None, new_description=None):
        
        if not department:
            raise ValueError("Department not found")
        
        if new_title:
            if not re.match("^[a-zA-Z0-9-_]{2,32}$", new_title):
                raise ValueError("Title doesn't respect the format")
            department.title = new_title
            department.head_role.title = new_title + " Head"
            department.proxy_role.title = new_title + " Proxy"
        if new_color:
            department.color = new_color
        if new_motto:
            department.motto = new_motto
        if new_logo:
            department.logo = new_logo
        if new_description:
            department.description = new_description
        
        db.session.commit()
    
    @staticmethod
    def create_division(title, department_title):
        # Create a new division with the given name, department, and leader
        
        if not re.match("^[a-zA-Z0-9-_]{2,32}$", title):
            raise ValueError("Title doesn't respect the format")
        
        department= Department.query.filter(func.lower(Department.title) == func.lower(department_title)).first()
        if department is None:
            raise ValueError("Department not found")
        
        department_test= Department.query.filter(func.lower(Department.title) == func.lower(title)).first()
        if department_test:
            raise ValueError("Disivision title already exist as a department")
        
        division_test= Division.query.filter(func.lower(Division.title) == func.lower(title)).first()
        if division_test:
            raise ValueError("Division title already exist")
        
        
        
        division = Division(title=title, department=department)
        db.session.add(division)
        db.session.commit()
        
        return division
    
    @staticmethod
    def update_division(division, new_title=None, new_motto=None, new_logo=None, new_security_level=None, new_description=None, new_restricted=None):
        if not division:
            return ValueError("Division not found")
    
        if new_title:
            if not re.match("^[a-zA-Z0-9-_]{2,32}$", new_title):
                raise ValueError("Title doesn't respect the format")
            division.title = new_title
            division.leader_role.title = new_title + " Leader"
            division.proxy_role.title = new_title + " Proxy"
        if new_motto:
            division.motto = new_motto
        if new_logo:
            division.logo = new_logo
        if new_security_level:
            division.security_requirement = new_security_level
        if new_description:
            division.description = new_description
        if new_restricted:
            division.restricted = new_restricted
        
        db.session.commit()
    
    @staticmethod
    def create_role(title, division=None, department=None):
        # Create a new role with the given name, division, and/or department
        
        if not re.match("^[a-zA-Z0-9-_ ]{2,32}$", title):
            raise ValueError("Title contain unallowed character")
        
        role_test= Role.query.filter(func.lower(Role.title) == func.lower(title)).first()
        if role_test:
            raise ValueError("Role title already exist")
        
        role = Role(title = title, division = division, department = department)
        
        db.session.add(role)
        db.session.commit()
    
    @staticmethod
    def update_role(role, new_title=None, new_discord_id=None, new_color=None, new_logo=None):
        if not role:
            return ValueError("Role not found")
        
        if new_title:
            if not re.match("^[a-zA-Z0-9-_ ]{2,32}$", new_title):
                raise ValueError("Title contain unallowed character")
            role.title = new_title
        if new_discord_id:
            role.discord_id = new_discord_id
        if new_color:
            role.color = new_color
        if new_logo:
            role.logo = new_logo
        
        db.session.commit()
    
    @staticmethod
    def get_role_type( role):
        
        if role.title == "Corporateer":
            return "Membership"
        if role.division != None and role.division.member_role == role:
            return "Membership"
        elif role.division != None and (role.division.leader_role == role or role.division.proxy_role == role):
            return "Leadership"
        elif role.department != None and (role.department.head_role == role or role.department.proxy_role == role):
            return "Leadership"
        else:
            return "Other"
