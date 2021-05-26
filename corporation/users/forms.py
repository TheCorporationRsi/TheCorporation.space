from flask_wtf import FlaskForm, RecaptchaField
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField, HiddenField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from corporation.models import User, Influence, Tribute, Division, Weight
from flask_wtf.file import FileField, FileAllowed
from corporation.data.scraping import RSI_account
from sqlalchemy import func


class RegistrationForm(FlaskForm):

    RSI_handle = StringField('RSI_handle', validators=[DataRequired(), Length(min=2, max=32)])

    email = StringField('Email', validators=[DataRequired(), Email()])

    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password', validators=[ DataRequired(), EqualTo('password')])

    submit = SubmitField('Sign Up')

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        RSI_info = RSI_account(RSI_handle= self.RSI_handle.data)
        if user:
            raise ValidationError('That email is already taken')
        
        elif RSI_info.email is None:
            raise ValidationError('Please add your email in your RSI bio')
        
        elif not RSI_info.confirm_email(email = email.data):
            print(email.data.lower())
            raise ValidationError('Email in the bio is not the same')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle.data)).first()
        RSI_info = RSI_account(RSI_handle= RSI_handle.data)
        if user:
            raise ValidationError(
                'That RSI_handle already have an account, pls contact moderator')


class LoginForm(FlaskForm):

    RSI_handle = StringField('RSI handle', validators=[DataRequired()])

    password = PasswordField('Password', validators=[DataRequired()])

    remember = BooleanField('Remember Me')

    recaptcha = RecaptchaField()

    submit = SubmitField('Sign In')


class UpdateAccountForm(FlaskForm):

    picture = FileField('Update Profile Picture', validators=[
                        FileAllowed(['jpeg', 'png'])])

    submit = SubmitField('Update')


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


class inf_Form(FlaskForm):
    RSI_handle = StringField('RSI handle', validators=[DataRequired(), Length(
        max=40)], render_kw={"placeholder": "Receiver"})
    amount = IntegerField('Amount', validators=[DataRequired(), NumberRange(
        min=1, max=1000, message='Not a valid amount!')], render_kw={"placeholder": "Amount"})
    message = TextAreaField('Message', validators=[DataRequired()])

    send = SubmitField('Send')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter_by(RSI_handle=RSI_handle.data).first()
        if not user:
            raise ValidationError('That this user doesn\'t have an account.')
        elif user.RSI_handle == current_user.RSI_handle:
            raise ValidationError('You cannot send influence to yourself')


    def validate_amount(self, amount):
        tribute = Tribute.query.filter_by(RSI_handle= current_user.RSI_handle ).first()
        if not tribute:
            raise ValidationError('Error: the account doesn\'t exist, please let CyberDreamer know.')
        elif tribute.amount < amount.data:
            raise ValidationError('Not enough tribue in your influence account.')



class weight_Form(FlaskForm):
    
    def __init__(self, member):
        self.member = member
    
    division = HiddenField("Field 1", validators=[DataRequired()])
    weight = IntegerField('Weight', validators=[DataRequired(), NumberRange( min=1, max=100, message='Not a valid amount!')], render_kw={"placeholder": "Weight"})
    
    send = SubmitField('Set')
    
    def validate_weight(self, weight):
        divisions = Division.query.all()
        total = 0
        for division in divisions:
            if division.had_member(self.member):
                percent = Weight.query.filter_by(RSI_handle= self.member.RSI_handle, division_id = division.id).first()
                total += percent.weight
                
        if total > 100:
            raise ValidationError('The total must be 100')
