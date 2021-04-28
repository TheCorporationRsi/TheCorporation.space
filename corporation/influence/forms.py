from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from corporation.models import Post, User, Role, Division, Department, Influence_account
from corporation import db

from wtforms.ext.sqlalchemy.fields import QuerySelectField


class MyForm(FlaskForm):
    RSI_handle = StringField('RSI handle', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Receiver"})
    amount = StringField('Amount', validators=[DataRequired(), Length(max=10)],render_kw={"placeholder": "Amount"})
    message = TextAreaField('Message', validators= [DataRequired()])
    
    submit = SubmitField('Send')

    def validate_RSI_handle(self, RSI_handle):
        user = User.query.filter_by(RSI_handle= RSI_handle.data).first()
        if not user:
            raise ValidationError('That this user doesn\'t have an account.')
    
    def validate_amount(self, amount):
        account_amount = Influence_account.query.filter_by(RSI_handle= current_user.RSI_handle ).first()
        if not account_amount:
            raise ValidationError('Error: the account doesn\'t exist, please let CyberDreamer know.')
        elif account_amount < amount:
            raise ValidationError('Not enough tribue in your influence account.')