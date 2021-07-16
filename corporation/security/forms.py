from flask_wtf import FlaskForm, RecaptchaField, Form
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField, HiddenField, FieldList, FormField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from corporation.models import User, Influence, Tribute, Division
from flask_wtf.file import FileField, FileAllowed
from corporation.data.scraping import RSI_account
from sqlalchemy import func


class RegistrationForm(FlaskForm):

    RSI_handle = StringField('RSI handle (Unique Start Citizen username)', validators=[DataRequired(), Length(min=2, max=32)])

    email = StringField('Email', validators=[DataRequired(), Email()])

    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password', validators=[ DataRequired(), EqualTo('password')])

    submit = SubmitField('Sign Up')
    
    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle.data)).first()
        RSI_info = RSI_account(RSI_handle= RSI_handle.data)
        if not RSI_info or RSI_info == None :
            raise ValidationError('Error in the RSI handle')  
        elif user:
            raise ValidationError(
                'That RSI_handle already have an account, pls contact moderator')

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        RSI_info = RSI_account(RSI_handle= self.RSI_handle.data)
        print(RSI_info)
        
        try:
            test = RSI_info.email
        except:
            raise ValidationError('Please add your email in your RSI bio')
        
        if not RSI_info or RSI_info == None:
            raise ValidationError('Error in the RSI handle')
        
        elif user and user.registered:
            raise ValidationError('That email is already taken')
        
        elif not RSI_info.email:
            raise ValidationError('Please add your email in your RSI bio')
        
        elif not RSI_info.confirm_email(email = email.data):
            print(email.data.lower())
            raise ValidationError('Email in the bio is not the same')



class LoginForm(FlaskForm):

    RSI_handle = StringField('RSI handle', validators=[DataRequired()])

    password = PasswordField('Password', validators=[DataRequired()])

    remember = BooleanField('Remember Me')

    recaptcha = RecaptchaField()

    submit = SubmitField('Sign In')


class RequestResetForm(FlaskForm):

    email = StringField('Email', validators=[DataRequired(), Email()])

    submit = SubmitField('Request reset')

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        if user is None:
            raise ValidationError(
                'There is no account with that email. You must register first!')


class ResetPasswordForm(FlaskForm):

    password = PasswordField('Password', validators=[DataRequired()])

    confirm_password = PasswordField('Confirm Password', validators=[
                                     DataRequired(), EqualTo('password')])

    submit = SubmitField('Reset password')


