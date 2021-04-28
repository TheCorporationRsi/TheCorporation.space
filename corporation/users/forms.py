from flask_wtf import FlaskForm, RecaptchaField
from wtforms import StringField, PasswordField, SubmitField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from corporation.models import User
from flask_wtf.file import FileField, FileAllowed
from corporation.users.utils import RSIverify


class RegistrationForm(FlaskForm):
    
    RSI_handle = StringField('RSI_handle',validators= [DataRequired(), Length(min=2, max=32)] )

    email = StringField('Email', validators=[DataRequired(), Email()])

    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), EqualTo('password')])
    
    submit = SubmitField('Sign Up')
    
    def validate_email(self, email):
        user = User.query.filter_by(email= email.data).first()
        if user:
            raise ValidationError('That email is already taken')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter_by(RSI_handle= RSI_handle.data).first()
        if user:
            raise ValidationError('That RSI_handle already have an account, pls contact moderator')
        elif RSIverify(RSI_handle, self.email) == 1:
            raise ValidationError('Please add your email in your RSI bio')
        


class LoginForm(FlaskForm):

    RSI_handle = StringField('RSI handle', validators=[DataRequired()])

    password = PasswordField('Password', validators=[DataRequired()])

    remember = BooleanField('Remember Me')
    
    recaptcha = RecaptchaField()

    submit = SubmitField('Sign In')



class UpdateAccountForm(FlaskForm):

    picture = FileField('Update Profile Picture', validators= [FileAllowed(['jpeg','png'])])

    submit = SubmitField('Update')

class RequestResetForm(FlaskForm):
    
    email = StringField('Email', validators=[DataRequired(), Email()])

    submit = SubmitField('Request reset')  
    
    def validate_email(self, email):
        user = User.query.filter_by(email= email.data).first()
        if user is None:
            raise ValidationError('There is no account with that email. You must register first!')
        
        

class ResetPasswordForm(FlaskForm):

    password = PasswordField('Password', validators=[DataRequired()])

    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), EqualTo('password')])
    
    submit = SubmitField('Reset password')        