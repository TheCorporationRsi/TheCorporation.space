from flask_wtf import FlaskForm, RecaptchaField
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from corporation.models import User, Influence_account, Influence
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
        elif RSIverify(RSI_handle, self.email) > 0:
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
    
    
class inf_Form(FlaskForm):
    RSI_handle = StringField('RSI handle', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Receiver"})
    amount = IntegerField('Amount', validators=[DataRequired(), NumberRange(min=1, max=1000, message='Not a valid amount!')],render_kw={"placeholder": "Amount"})
    message = TextAreaField('Message', validators= [DataRequired()])
    
    send = SubmitField('Send')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter_by(RSI_handle= RSI_handle.data).first()
        if not user:
            raise ValidationError('That this user doesn\'t have an account.')
        elif user.RSI_handle == current_user.RSI_handle:
            raise ValidationError('You cannot send influence to yourself')
            
    
    def validate_amount(self, amount):
        account_amount = Influence_account.query.filter_by(RSI_handle= current_user.RSI_handle ).first()
        if not account_amount:
            raise ValidationError('Error: the account doesn\'t exist, please let CyberDreamer know.')
        elif account_amount.tribute < amount.data:
            raise ValidationError('Not enough tribue in your influence account.')