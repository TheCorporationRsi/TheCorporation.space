from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager
from flask_login import UserMixin
from flask import current_app


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))



#========================================================================
# User Database
#========================================================================


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    
    #User info
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    image_file = db.Column(db.String(20), nullable= False, default='default.jpg' )
    
    #Linked account
    discord_username = db.Column(db.String(32), unique=True, nullable=True)
    discord_id = db.Column(db.String(32), unique=True, nullable=True)
    
    guilded_username = db.Column(db.String(32), unique=False, nullable=True)
    guilded_id = db.Column(db.String(32), unique=True, nullable=True)
    
    #Security level
    security = db.Column(db.Integer, unique=False, nullable=True)
    email_confirmed = db.Column(db.Boolean, nullable=False, default= False)
    corp_confirmed = db.Column(db.Boolean, nullable=False, default= False)

    def get_reset_token(self, expires_sec= 1800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')
    
    def get_confirmation_token(self, expires_sec= 172800):
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
        links = Rolevsuser.query.filter_by(RSI_handle = self.RSI_handle).all()
        roles = []
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            roles.append(role)
        return roles
    
    def has_role(self, role):
        links = Rolevsuser.query.filter_by(RSI_handle = self.RSI_handle).all()
        for link in links:
            if link.role_id == role.id:
                return True
        return False
    
    def is_manager(self, manager_type = None, division = -1 , department = -1):
        if self.security == 5:
            return True
        links = Rolevsuser.query.filter_by(RSI_handle = self.RSI_handle).all() 
        if division == -1  and department == -1:
            for link in links:
                if manager_type == None and (link.role.dep_head or link.role.dep_proxy or link.role.div_head or link.role.div_proxy):
                    return True
                elif(manager_type == "dep_head" and link.role.dep_head ):
                    return True
                elif(manager_type == "div_head" and link.role.div_head ):
                    return True
                elif(manager_type == "dep_proxy" and link.role.dep_proxy ):
                    return True
                elif(manager_type == "div_proxy" and link.role.div_proxy ):
                    return True
                
        elif division == 0  and department == 0:
            if self.security == 5:
                return True
            
        elif division > -1:
            division = Division.query.filter_by(id = division).first()
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
        
    def as_dict(self):
        return {'name': self.RSI_handle}     

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"

#========================================================================
# User Database
#========================================================================
# Role database
#========================================================================


class Rolevsuser(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    RSI_handle = db.Column(db.String(32), nullable=False)

class Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    
    division_id = db.Column(db.Integer, db.ForeignKey('division.id'), nullable= True)
    dep_head = db.Column(db.Boolean, nullable=False, default= False)
    dep_proxy = db.Column(db.Boolean, nullable=False, default= False)
    department_id = db.Column(db.Integer, db.ForeignKey('department.id'), nullable= True)
    div_head = db.Column(db.Boolean, nullable=False, default= False)
    div_proxy = db.Column(db.Boolean, nullable=False, default= False)
    
    discord_id = db.Column(db.Integer, unique=True, nullable=True)
    guilded_id = db.Column(db.Integer, unique=True, nullable=True)
    
    def member_count(self):
        return Rolevsuser.query.filter_by(role_id = self.id).count()
    
    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"
    
class Division(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    
    
    roles = db.relationship('Role', backref='division', lazy='dynamic')
    department_id = db.Column(db.Integer, db.ForeignKey('department.id'), nullable=False)
    
    
    def member_count(self):
        users = []
        for role in self.roles:
            members = Rolevsuser.query.filter_by(role_id = role.id).all()
            for member in members:
                user = User.query.filter_by(RSI_handle = member.RSI_handle).first()
                if user not in users:
                    users.append(user)
        return len(users)
    
    def __repr__(self):
        return f"Division('{self.title}', '{self.date_added}')"
    
class Department(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    
    roles = db.relationship('Role', backref='department', lazy='dynamic')
    divisions = db.relationship('Division', backref='department', lazy='dynamic')
    
    def member_count(self):
        users = []
        for role in self.roles:
            members = Rolevsuser.query.filter_by(role_id = role.id).all()
            for member in members:
                user = User.query.filter_by(RSI_handle = member.RSI_handle).first()
                if user not in users:
                    users.append(user)
        return len(users)
    
    def __repr__(self):
        return f"Department('{self.title}', '{self.date_added}')"

#========================================================================
# Role Database
#========================================================================
# Social database
#========================================================================   
class Post(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    chat = db.relationship('Message', backref='container', lazy=True)
    RSI_handle = db.Column(db.String(32), nullable=False)
    
    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"
    
class Message(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    sender = db.Column(db.String(32), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    link = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)

    def __repr__(self):
        return f"Message('{self.title}', '{self.date_posted}')"

#========================================================================
# Social Database
#========================================================================
# Influence database
#========================================================================

class Influence_account(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    date_updated = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    lifetime_influence = db.Column(db.Integer, nullable= False, default=0)
    tribute = db.Column(db.Integer, nullable= False, default=0)
    
    def update(self):
        return 0
    
    def __repr__(self):
        return f"Account('{self.title}', '{self.date_added}')"
    
class Influence_rank(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    
    def member_count(self):
        return Influence_account.query.filter_by(rank = self.id).count()
    
    def __repr__(self):
        return f"Rank('{self.title}', '{self.date_added}')"

class Influence(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(32), unique=False, nullable=False)
    RSI_handle = db.Column(db.String(32), unique=False, nullable=False)
    influence = db.Column(db.Integer, nullable= False, default=0)
    lifetime_influence = db.Column(db.Integer, nullable= False, default=0)
    tribute = db.Column(db.Integer, nullable= False, default=0)
    
    def __repr__(self):
        return f"Influence('{self.title}', '{self.date_added}')"
    
class Influence_transaction(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    user_from = db.Column(db.String(32), unique=True, nullable=False)
    user_to = db.Column(db.String(32), unique=True, nullable=False)
    amount = db.Column(db.Integer, nullable= False, default=0)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    message = db.Column(db.Text, nullable=True)
    
    def member_count(self):
        return Influence_account.query.filter_by(rank = self.id).count()
    
    def __repr__(self):
        return f"Transaction('{self.title}', '{self.date_added}')"


#========================================================================
# Influence Database
#========================================================================
# Logs database
#========================================================================
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