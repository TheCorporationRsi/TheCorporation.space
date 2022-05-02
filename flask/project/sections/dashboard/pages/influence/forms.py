from flask_wtf import FlaskForm, RecaptchaField, Form
from wtforms import StringField, SubmitField, TextAreaField, SelectField, IntegerField, HiddenField, FieldList, FormField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from project.models import User, Role, Division, Department
from project import db
from sqlalchemy import func

#from wtforms.ext.sqlalchemy.fields import QuerySelectField


class Influence_form(FlaskForm):
    RSI_handle = StringField('RSI handle', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Receiver"})
    amount = IntegerField('Amount', validators=[DataRequired(), NumberRange(min=1, max=1000, message='Not a valid amount!')],render_kw={"placeholder": "Amount"})
    message = TextAreaField('Message', validators= [DataRequired()])
    
    submit = SubmitField('Send')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle.data)).first()
        if not user:
            raise ValidationError('This user doesn\'t have an account.')
        elif not user.RSI_confirmed :
            raise ValidationError('This user didn\'t verified his account yet.')
        elif not user.corp_confirmed:
            raise ValidationError('This user doesn\'t belong in the CORP.')
        elif user.RSI_handle == current_user.RSI_handle or user == current_user:
            raise ValidationError('You cannot send influence to yourself')
            
    
    def validate_amount(self, amount):
        if current_user.tribute < amount.data:
            raise ValidationError('Not enough tribute in your influence account.') 
        

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