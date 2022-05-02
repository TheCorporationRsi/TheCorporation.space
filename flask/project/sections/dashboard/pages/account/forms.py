from flask_wtf import FlaskForm, RecaptchaField, Form
from wtforms import StringField, PasswordField, SubmitField, BooleanField, IntegerField, TextAreaField, HiddenField, FieldList, FormField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from project.models import User, Influence, Division
from flask_wtf.file import FileField, FileAllowed
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func



class UpdateAccountForm(FlaskForm):

    picture = FileField('Update Profile Picture', validators=[
                        FileAllowed(['jpeg', 'png'])])

    submit = SubmitField('Update')
