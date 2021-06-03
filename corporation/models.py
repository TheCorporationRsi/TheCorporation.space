from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager
from flask_login import UserMixin
from flask import current_app

from sqlalchemy import or_


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# ========================================================================
# User Database
# ========================================================================


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)

    # User info
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    RSI_moniker = db.Column(db.String(32), nullable=True)
    RSI_number = db.Column(db.Integer, nullable=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    image_file = db.Column(db.String(20), nullable=False, default='default.jpg')

    # Linked account
    discord_username = db.Column(db.String(32), unique=True, nullable=True)
    discord_id = db.Column(db.String(32), unique=True, nullable=True)

    guilded_username = db.Column(db.String(32), unique=False, nullable=True)
    guilded_id = db.Column(db.String(32), unique=True, nullable=True)

    # Security level
    security = db.Column(db.Integer, unique=False, nullable=True)
    email_confirmed = db.Column(db.Boolean, nullable=False, default=False)
    corp_confirmed = db.Column(db.Boolean, nullable=False, default=False)

    def get_reset_token(self, expires_sec=1800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    def get_confirmation_token(self, expires_sec=172800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    @staticmethod
    def verify_reset_token(token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            user_id = s.loads(token)['user_id']
        except:
            return None
        return User.query.get(user_id)

    def roles(self):
        links = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle).all()
        roles = []
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            roles.append(role)
        roles.sort(key=lambda x: x.department_id)
        return roles

    def has_role(self, role):
        link = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle, role_id = role.id).first()
        if link:
            return True
        return False
    
    def his_member(self, division):
        links = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle).all()
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            if role.div_member and role.division_id == division.id:
                return True
        return False
    
    def his_member_dep(self, department):
        links = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle).all()
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            if role.div_member and role.department_id == department.id:
                return True
        return False

    def div_weight(self, division):
        role = Role.query.filter_by(division_id=division.id, div_member= True).first()
        link = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle, role_id = role.id).first()
        return link.weight
    
    def add_role(self, role):
        link = Rolevsuser( RSI_handle = self.RSI_handle, role_id = role.id)
        db.session.add(link)
        db.session.commit()
        
    def is_manager(self, manager_type=None, division=-1, department=-1):
        if self.security == 5:
            return True
        links = Rolevsuser.query.filter_by(RSI_handle=self.RSI_handle).all()
        if division == -1 and department == -1:
            for link in links:
                if manager_type == None and (link.role.dep_head or link.role.dep_proxy or link.role.div_head or link.role.div_proxy):
                    return True
                elif(manager_type == "dep_head" and link.role.dep_head):
                    return True
                elif(manager_type == "div_head" and link.role.div_head):
                    return True
                elif(manager_type == "dep_proxy" and link.role.dep_proxy):
                    return True
                elif(manager_type == "div_proxy" and link.role.div_proxy):
                    return True

        elif division == 0 and department == 0:
            if self.security == 5:
                return True

        elif division > -1:
            division = Division.query.filter_by(id=division).first()
            for link in links:
                if ((link.role.dep_head or link.role.div_head) and link.role.division_id == division.id):
                    return True

        elif department > -1:
            for link in links:
                if (link.role.dep_head and link.role.department_id == department):
                    return True

        return False

    def highest_rank(self):

        if self.security == 5:
            return "admin"
        elif self.is_manager("dep_head"):
            for link in self.roles:
                if link.role.dep_head:
                    return link.role
        elif self.is_manager():
            for link in self.roles:
                if link.role.div_head:
                    return link.role
        else:
            return None

    def tribute(self):
        tribute = Tribute.query.filter_by(RSI_handle=self.RSI_handle).first()
        
        if not tribute:
            self.upgrade()
        
        tribute = Tribute.query.filter_by(RSI_handle=self.RSI_handle).first()
        
        return tribute
    
    def send_tribute(self, receiver, amount, message= "none"):
        tribute = self.tribute()
        receiver_links = Rolevsuser.query.filter_by(RSI_handle= receiver.RSI_handle).all()
        
        count = 0
        for link in receiver_links:
            count += link.weight
        
        if count == 0:
            test = 0
            for link in receiver_links:
                role = Role.query.filter_by(id = link.role_id).first()
                if role.div_member:
                    test += 1
                    
            if test == 0:
                transaction = Influence_transaction(user_from = self.RSI_handle, user_to = receiver.RSI_handle, amount= amount, message = message)
                db.session.add(transaction)
                tribute.amount -= amount
                influence = Influence(RSI_handle = receiver.RSI_handle, amount = amount, department = 0, division = 0)
                influence2 = Influence(RSI_handle = self.RSI_handle, amount = amount, department = 0, division = 0)
                db.session.add(influence)
                db.session.add(influence2)
                db.session.commit()
                return 0
            else:
                for link in receiver_links:
                    role = Role.query.filter_by(id = link.role_id).first()
                    if role.div_member:
                        link.weight = 100/test
        
        if count > 100 or tribute.amount < amount:
            print("error in "+ receiver.RSI_handle+" influence")
            return -1
        else:
            common_weight = 0
            for link in receiver_links:
                role = Role.query.filter_by(id = link.role_id).first()
                if role.div_member and link.weight > 0:
                    department = Department.query.filter_by(id = role.department_id).first()
                    if self.has_role(role) or self.his_member_dep(department) :
                        common_weight += link.weight
                        
            if common_weight == 0:
                transaction = Influence_transaction(user_from = self.RSI_handle, user_to = receiver.RSI_handle, amount= amount, message = message)
                db.session.add(transaction)
                tribute.amount -= amount
                influence = Influence(RSI_handle = receiver.RSI_handle, amount = amount, department = 0, division = 0)
                influence2 = Influence(RSI_handle = self.RSI_handle, amount = amount, department = 0, division = 0)
                db.session.add(influence)
                db.session.add(influence2)
                db.session.commit()
                return 0
            
            transaction = Influence_transaction(user_from = self.RSI_handle, user_to = receiver.RSI_handle, amount= amount, message = message)
            db.session.add(transaction)
            tribute.amount -= amount
            for link in receiver_links:
                role = Role.query.filter_by(id = link.role_id).first()
                if role.div_member and link.weight > 0:
                    department = Department.query.filter_by(id = role.department_id).first()
                    if self.has_role(role):
                        influence = Influence(RSI_handle = receiver.RSI_handle, amount = amount*link.weight/common_weight, department = role.department_id, division = role.division_id)
                        influence2 = Influence(RSI_handle = self.RSI_handle, amount = amount*link.weight/common_weight, department = role.department_id, division = role.division_id)
                    elif self.his_member_dep(department):
                        influence = Influence(RSI_handle = receiver.RSI_handle, amount = amount*link.weight/common_weight, department = role.department_id, division = 0)
                        influence2 = Influence(RSI_handle = self.RSI_handle, amount = amount*link.weight/common_weight, department = role.department_id, division = 0)
                    db.session.add(influence)
                    db.session.add(influence2)
        db.session.commit()
        return 0
    
    def upgrade(self):
        tribute = Tribute.query.filter_by(RSI_handle=self.RSI_handle).first()
        
        if not tribute:
            tribute = Tribute(RSI_handle=self.RSI_handle)
            db.session.add(tribute)
            db.session.commit()
    
    def influence_count(self, type=None, department=None, division=None):
        
        if type == "general":
            influences = Influence.query.filter_by(RSI_handle=self.RSI_handle, department = department, division = division).all()
        elif department is None and division is None:
            influences = Influence.query.filter_by(RSI_handle=self.RSI_handle).all()
        elif division is None:
            influences = Influence.query.filter_by(RSI_handle=self.RSI_handle, department = department).all()
        else:
            influences = Influence.query.filter_by(RSI_handle=self.RSI_handle, department = department, division = division).all()
        count = 0
        for influence in influences:
            count += influence.amount

        return count

    def lifetime_influence_count(self, type = None, department=None, division=None):
        
        if type == "general":
            influences = Influence_transaction.query.filter(or_( Influence_transaction.user_to == self.RSI_handle, Influence_transaction.user_from == self.RSI_handle,)).filter_by( department = department, division = division).all()
        elif department is None and division is None:
            influences = Influence_transaction.query.filter(or_( Influence_transaction.user_to == self.RSI_handle, Influence_transaction.user_from == self.RSI_handle,)).all()
        elif division is None:
            influences = Influence_transaction.query.filter(or_( Influence_transaction.user_to == self.RSI_handle, Influence_transaction.user_from == self.RSI_handle,)).filter_by( department = department).all()
        else:
            influences = Influence_transaction.query.filter(or_( Influence_transaction.user_to == self.RSI_handle, Influence_transaction.user_from == self.RSI_handle,)).filter_by( department = department, division = division).all()
            
        count = 0
        for influence in influences:
            count += influence.amount

        return count

    def influence_rank(self):
        ranks = Influence_rank.query.order_by(Influence_rank.required_influence.desc()).all()
        lifetime_influence = self.lifetime_influence_count()
        
        for rank in ranks:
            if lifetime_influence >= rank.required_influence:
                return rank

    def receive_weekly_tribute(self):
        rank = self.influence_rank()
        tribute = self.tribute()
        
        tribute.amount += rank.weekly_amount
        
        if tribute.amount > 1.5*rank.weekly_amount:
            tribute.amount = 1.5*rank.weekly_amount
            
        db.session.commit()
            
    def as_dict(self):
        return {
            'name': self.RSI_handle,
            'moniker': self.RSI_moniker
            }

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"

# ========================================================================
# User Database
# ========================================================================
# Role database
# ========================================================================



    
class Rolevsuser(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    RSI_handle = db.Column(db.String(32), nullable=False)
    weight = db.Column(db.Integer, nullable=True, default= 0)


class Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    color = db.Column(db.String(32), unique=False, nullable=True)
    rule = db.Column( db.Integer, nullable=True, default= 0)
    
    division_id = db.Column(
        db.Integer, db.ForeignKey('division.id'), nullable=True)
    dep_head = db.Column(db.Boolean, nullable=False, default=False)
    dep_proxy = db.Column(db.Boolean, nullable=False, default=False)
    department_id = db.Column( db.Integer, db.ForeignKey('department.id'), nullable=True)
    div_head = db.Column(db.Boolean, nullable=False, default=False)
    div_proxy = db.Column(db.Boolean, nullable=False, default=False)
    div_member = db.Column(db.Boolean, nullable=False, default=False)
    
    discord_id = db.Column(db.Integer, unique=True, nullable=True)
    guilded_id = db.Column(db.Integer, unique=True, nullable=True)

    def member_count(self):
        return Rolevsuser.query.filter_by(role_id=self.id).count()
    
    def role_color(self):
        if self.department_id:
            department = Department.query.filter_by(id = self.department_id).first()
            return department.color
        elif self.color:
            return self.color
        else:
            return "white"

    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"


class Division(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    roles = db.relationship('Role', backref='division', lazy='dynamic')
    department_id = db.Column(db.Integer, db.ForeignKey(
        'department.id'), nullable=False)
    logo = db.Column(db.String(20), nullable=False, default='default.jpg')
    moto = db.Column(db.String(200), nullable=False, default= 'Empty')
    def member_count(self):
        users = []
        for role in self.roles:
            members = Rolevsuser.query.filter_by(role_id=role.id).all()
            for member in members:
                user = User.query.filter_by(
                    RSI_handle=member.RSI_handle).first()
                if user not in users:
                    users.append(user)
        return len(users)

    def has_member(self, member):
        for role in self.roles:
            if member.has_role(role):
                return True
        return False
    
    def color(self):
        department = Department.query.filter_by(id = self.department_id).first()
        return department.color
    
    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title, 
            'color': self.color()
            }
    
    def __repr__(self):
        return f"Division('{self.title}', '{self.date_added}')"


class Department(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    color = db.Column(db.String(32), unique=False, nullable=False, default='red')
    roles = db.relationship('Role', backref='department', lazy='dynamic')
    divisions = db.relationship(
        'Division', backref='department', lazy='dynamic')

    def member_count(self):
        users = []
        for role in self.roles:
            members = Rolevsuser.query.filter_by(role_id=role.id).all()
            for member in members:
                user = User.query.filter_by(
                    RSI_handle=member.RSI_handle).first()
                if user not in users:
                    users.append(user)
        return len(users)
    
    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title, 
            'color': self.color
            }

    def __repr__(self):
        return f"Department('{self.title}', '{self.date_added}')"

class Webpage_template(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column( db.Integer, nullable=True, default= 0)
    title = db.Column(db.String(100), nullable=False, default='empty')
    title2 = db.Column(db.String(100), nullable=False, default='empty')
    text = db.Column(db.String(200), nullable=False, default= 'Empty')
    background_image = db.Column(db.String(20), nullable=False, default='default.jpg')
    
    division_id = db.Column( db.Integer, db.ForeignKey('division.id'), nullable=True)
    department_id = db.Column( db.Integer, db.ForeignKey('department.id'), nullable=True)
    def __repr__(self):
        return f"Department('{self.title}', '{self.background_image}')"
    
# ========================================================================
# Role Database
# ========================================================================
# Social database
# ========================================================================


class Post(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False,
                            default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    chat = db.relationship('Message', backref='container', lazy=True)
    RSI_handle = db.Column(db.String(32), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"


class Message(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    sender = db.Column(db.String(32), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False,
                            default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    link = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)

    def __repr__(self):
        return f"Message('{self.title}', '{self.date_posted}')"

# ========================================================================
# Social Database
# ========================================================================
# Influence database
# ========================================================================


class Tribute(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    last_payment = db.Column(
        db.DateTime, nullable=False, default=datetime.utcnow)
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    amount = db.Column(db.Integer, nullable=False, default=0)

    def update(self):
        now = datetime.now()
        delta = now - self.last_payment
        days = delta.days

        last_friday = now + \
            timedelta(days=(4 - now.weekday())) - timedelta(days=7)
        last_friday.replace(minute=0, hour=0, second=0, microsecond=0)
        while days > 7:
            self.amount += 50

            self.last_payment += timedelta(days=7)
            delta = now - self.last_payment
            days = delta.days

        self.last_payment = last_friday

        return delta

    def __repr__(self):
        return f"Account('{self.RSI_handle}', '{self.last_payment}')"


class Influence_rank(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    required_influence = db.Column(db.Integer, unique= True, nullable=False, default=0)
    created_by = db.Column(db.String(32), nullable=False)
    weekly_amount = db.Column(db.Integer, unique= True, nullable=False, default= 50)

    def member_count(self):
        ...
        #return Influence_account.query.filter_by(rank=self.id).count()

    def __repr__(self):
        return f"Rank('{self.title}', '{self.date_added}')"


class Influence(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    RSI_handle = db.Column(db.String(32), unique=False, nullable=False)
    amount = db.Column(db.Integer, nullable=False, default=0)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    
    department = db.Column(db.Integer, nullable= True, default = 0)
    division = db.Column(db.Integer, nullable= True, default = 0)

    def __repr__(self):
        return f"Influence_history('{self.title}', '{self.date_added}')"


class Influence_transaction(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    user_from = db.Column(db.String(32), nullable=False)
    user_to = db.Column(db.String(32), nullable=False)
    method = db.Column(db.String(32), nullable=False, default='unkown')
    amount = db.Column(db.Integer, nullable=False, default=0)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    message = db.Column(db.Text, nullable=True)

    def __repr__(self):
        return f"Transaction('{self.title}', '{self.date_added}')"


# ========================================================================
# Influence Database
# ========================================================================
# Logs database
# ========================================================================
class Logs(db.Model):
    __bind_key__ = 'logs_db'
    id = db.Column(db.Integer, primary_key=True)
    RSI_handle = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    action_type = db.Column(db.String(100), nullable=False)
    original = db.Column(db.String(100), nullable=False)
    Result = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f"Logs('{self.title}', '{self.user_id}', '{self.date_added}')"


''' 
class News_post(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    videos = db.relationship('Videos', backref='news', lazy=True)
    image = db.relationship('Image', backref='news', lazy=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"

class Video(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    video = db.Column(db.String(60), nullable=False)
    news_id = db.Column(db.Integer, db.ForeignKey('news_post.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.video}', '{self.date_posted}')"
    
class Image(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(60), nullable=False)
    news_id = db.Column(db.Integer, db.ForeignKey('news_post.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.video}', '{self.date_posted}')" '''
