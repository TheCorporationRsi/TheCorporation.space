from flask_wtf import FlaskForm, Form
from wtforms import StringField, SubmitField, TextAreaField, SelectField, HiddenField, RadioField, FileField, FieldList, FormField, IntegerField
from flask_wtf.file import FileField, FileAllowed
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from corporation.models import Post, User, Role, Division, Department
from corporation import db

from wtforms.ext.sqlalchemy.fields import QuerySelectField


class Role_edit_Form(FlaskForm):
    
    role_id = HiddenField('Field', validators= [DataRequired()] )
    
    discord_id = IntegerField('Discord id')
    

    update = SubmitField('Update')
    
    def validate_role_id(self, role_id):
        test = Role.query.filter_by(id = role_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_discord_id(self, discord_id):
        test = Role.query.filter_by(discord_id=discord_id.data ).all()
        test2 = Role.query.filter_by(id = self.role_id.data ).first()
        if test and test != test2:
            raise ValidationError('Cannot be the same as a role that exist!')

