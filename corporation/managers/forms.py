from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from corporation.models import Post, User, Role, Division, Department
from corporation import db

from wtforms.ext.sqlalchemy.fields import QuerySelectField


class Department_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    submit = SubmitField('Create')
    
    def validate_title(self, title):
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same as a division that exist!')
    
class Division_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    department = QuerySelectField(query_factory=lambda: Department.query.all(), get_label='title', allow_blank=False, blank_text=(u'Select a department'), get_pk=lambda x: x.id)
    
    submit = SubmitField('Create')
    
    def validate_title(self, title):
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same as a department that exist!')
    

class Role_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    division = QuerySelectField(query_factory=lambda: Division.query.all(), get_label='title', allow_blank= True, blank_text=(u'No division'), get_pk=lambda x: x.id)
    
    submit = SubmitField('Create')
    
    def validate_title(self, title):
        test = Role.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same as a division that exist!')
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same as a department that exist!')
        

