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
        elif not user.corp_confirmed:
            raise ValidationError('This member is not a coorporateer!')


    def validate_amount(self, amount):
        tribute = Tribute.query.filter_by(RSI_handle= current_user.RSI_handle ).first()
        if not tribute:
            raise ValidationError('Error: the account doesn\'t exist, please let CyberDreamer know.')
        elif tribute.amount < amount.data:
            raise ValidationError('Not enough tribue in your influence account.')


class Division_weight(Form):
    division = HiddenField("Division", validators=[DataRequired()])
    weight = IntegerField('Weight', validators=[NumberRange(min=0, max=100)], default=0)

class Divisions_weight(FlaskForm):
    weights = FieldList(FormField(Division_weight), min_entries=0,  max_entries= 300)
    set = SubmitField('Set')
    
    def validate_weights(self, weights):
        count = 0
        for form in weights:
            count += form.weight.data
            
        if not count == 100:
            raise ValidationError('The total must be 100')