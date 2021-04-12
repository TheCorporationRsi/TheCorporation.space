from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager
from flask_login import UserMixin
from flask import current_app


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class Rolevsuser(db.Model):
    __bind_key__ = 'role_db'
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    role = db.relationship("Role", back_populates="members")
    user = db. relationship("User", back_populates="roles")


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    
    #User info
    RSI_handle = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    image_file = db.Column(db.String(20), nullable= False, default='default.jpg' )
    
    #Linked account
    discord_username = db.Column(db.String(20), unique=True, nullable=True)
    discord_id =db.Column(db.String(20), unique=True, nullable=True)
    
    guilded_username = db.Column(db.String(20), unique=False, nullable=True)
    guilded_id =db.Column(db.String(20), unique=True, nullable=True)
    
    #Security level
    security = db.Column(db.Integer, unique=False, nullable=True)
    
    #Content
    posts = db.relationship('Post', backref='author', lazy=True)
    
    #role
    roles = db.relationship("Rolevsuser", back_populates="user", lazy='dynamic')

    def get_reset_token(self, expires_sec= 1800):
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
    
    def has_role(self, role):
        for link in self.roles:
            if link.role == role:
                return True
        return False
    
    def is_manager(self, manager_type = None, division = -1 , department = -1):
        if self.security == 5:
            return True
        
        if division == -1  and department == -1:
            for link in self.roles:
                if (link.role.dep_head and (manager_type == "dep_head" or manager_type == None)) or (link.role.div_head and manager_type == None):
                    return True
                
        elif division == 0  and department == 0:
            if self.security == 5:
                return True
                
        elif department > -1:
            for link in self.roles:
                if (link.role.dep_head and link.role.department_id == department):
                    return True
                
        elif division > -1:
            division = Division.query.filter_by(id = division).first()
            for link in self.roles:
                if (link.role.dep_head and link.role.department_id == division.department_id ) or (link.role.div_head and link.role.division_id == division.id):
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

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"



class Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    members = db.relationship("Rolevsuser", back_populates="role", lazy='dynamic')
    
    division_id = db.Column(db.Integer, db.ForeignKey('division.id'), nullable= True)
    dep_head = db.Column(db.Boolean, nullable=False, default= False)
    department_id = db.Column(db.Integer, db.ForeignKey('department.id'), nullable= True)
    div_head = db.Column(db.Boolean, nullable=False, default= False)
    
    def member_count(self):
        return self.members.count()
    
    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"
    
class Division(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    
    roles = db.relationship('Role', backref='division', lazy='dynamic')
    department_id = db.Column(db.Integer, db.ForeignKey('department.id'), nullable=False)
    
    
    def member_count(self):
        users = []
        for role in self.roles:
            for member in role.members:
                user = User.query.filter_by(id = member.user_id).first()
                if user not in users:
                    users.append(user)
        return len(users)
    
    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"
    
class Department(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    roles = db.relationship('Role', backref='department', lazy='dynamic')
    divisions = db.relationship('Division', backref='department', lazy='dynamic')
    
    def member_count(self):
        users = []
        for role in self.roles:
            for member in role.members:
                user = User.query.filter_by(id = member.user_id).first()
                if user not in users:
                    users.append(user)
        return len(users)
    
    def __repr__(self):
        return f"Division('{self.title}', '{self.date_added}')"

    
class Post(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    chat = db.relationship('Message', backref='container', lazy=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"
    
class Message(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    sender = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    link = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"







class Logs(db.Model):
    __bind_key__ = 'logs_db'
    id = db.Column(db.Integer, primary_key=True)
    RSI_handle = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    action_type = db.Column(db.String(100), nullable=False)
    original = db.Column(db.String(100), nullable=False)
    Result = db.Column(db.String(100), nullable=False)
    
    def __repr__(self):
        return f"Post('{self.title}', '{self.user_id}', '{self.date_added}')"




    
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