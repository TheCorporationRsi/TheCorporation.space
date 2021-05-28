from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField, HiddenField
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
        


class Search_Form(FlaskForm):
    
    RSI_handle = StringField('RSI handle', validators= [DataRequired()] )
    
    submit = SubmitField('Search')
    
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


class Dep_Form(FlaskForm):
    
    department_id = HiddenField('Field', validators= [DataRequired()] )
    
    title = StringField('Title', validators= [DataRequired()] )
    
    color = StringField('Color', validators= [DataRequired()] )
    
    update = SubmitField('Update')
    
    def validate_department_id(self, department_id):
        test = Department.query.filter_by(id = department_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_title(self, title):
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        
        test = Department.query.filter_by(title = title.data).first()
        test2 = Department.query.filter_by(id = self.department_id.data, title = title.data).first()
        if test and not test2:
            raise ValidationError('Cannot be the same as a department that exist!')
        
    def validate_color(self, color):
        test = Department.query.filter_by(color = color.data).first()
        test2 = Department.query.filter_by(id = self.department_id.data, color = color.data).first()
        if test and not test2:
            raise ValidationError('Cannot be the same color!')
    