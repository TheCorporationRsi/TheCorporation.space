from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from corporation.models import Post, User, Role, Division, Department
from corporation import db

from wtforms.ext.sqlalchemy.fields import QuerySelectField


class MyForm(FlaskForm):
    country = StringField('Country', validators=[DataRequired(),
	Length(max=40)],render_kw={"placeholder": "country"})
