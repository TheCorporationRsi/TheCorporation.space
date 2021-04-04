from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager
from flask_login import UserMixin
from flask import current_app


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

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
    roles = db.relationship('User_Role', backref='member', lazy=True)

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

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"

class User_Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    division_id = db.Column(db.Integer, db.ForeignKey('division.id'), nullable=True)
    departement_id = db.Column(db.Integer, db.ForeignKey('departement.id'), nullable=False)
    
    def __repr__(self):
        return f"Post('{self.title}', '{self.user_id}', '{self.date_added}')"

class Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    division_id = db.Column(db.Integer, db.ForeignKey('division.id'), nullable=False)
    departement_id = db.Column(db.Integer, db.ForeignKey('departement.id'), nullable=False)
    members = db.relationship('User_Role', backref='role', lazy=True)
    
    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"
    
class Division(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    roles = db.relationship('Role', backref='division', lazy=True)
    departement_id = db.Column(db.Integer, db.ForeignKey('departement.id'), nullable=False)
    
    members = db.relationship('User_Role', backref='division', lazy=True)
    
    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"
    
class Departement(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    
    roles = db.relationship('Role', backref='departement', lazy=True)
    divisions = db.relationship('Division', backref='departement', lazy=True)
    
    members = db.relationship('User_Role', backref='departement', lazy=True)
    
    admins = db.relationship('User', backref='user.id', lazy=True)
    
    
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