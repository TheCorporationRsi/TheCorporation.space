from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField, IntegerField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from project.models import User, Role, Division, Department
from project import db

#from wtforms.ext.sqlalchemy.fields import QuerySelectField


class MyForm(FlaskForm):
    RSI_handle = StringField('RSI handle', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Receiver"})
    amount = IntegerField('Amount', validators=[DataRequired(), NumberRange(min=1, max=1000, message='Not a valid amount!')],render_kw={"placeholder": "Amount"})
    message = TextAreaField('Message', validators= [DataRequired()])
    
    submit = SubmitField('Send')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter_by(RSI_handle= RSI_handle.data).first()
        if not user:
            raise ValidationError('That this user doesn\'t have an account.')
        elif user.RSI_handle == current_user.RSI_handle:
            raise ValidationError('You cannot send influence to yourself')
            
    
"""     def validate_amount(self, amount):
        account_amount = Influence_account.query.filter_by(RSI_handle= current_user.RSI_handle ).first()
        if not account_amount:
            raise ValidationError('Error: the account doesn\'t exist, please let CyberDreamer know.')
        elif account_amount.tribute < amount.data:
            raise ValidationError('Not enough tribue in your influence account.') """