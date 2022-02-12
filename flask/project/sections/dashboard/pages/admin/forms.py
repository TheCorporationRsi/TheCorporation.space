from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField, HiddenField, RadioField, FileField, FieldList, FormField, IntegerField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, NumberRange
from flask_login import current_user
from project.models import User, Role, Division, Department
from project import db
from sqlalchemy import or_

#from wtforms.ext.sqlalchemy.fields import QuerySelectField


class add_department_form(FlaskForm):
    title = StringField('Title', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Exploration"})
    color = StringField('Color', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Green or #RGB"})
    
    submit = SubmitField('Create')

    def validate_title(self, title):
        department = Department.query.filter_by(title = title.data).first()
        if department:
            raise ValidationError('This department allready exist.')
    
    def validate_color(self, color):
        department = Department.query.filter_by(color = color.data).first()
        if department:
            raise ValidationError('This color is allready used.')


class add_division_form(FlaskForm):
    department_title = StringField('Department', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Exploration"})
    title = StringField('Title', validators=[DataRequired(), Length(max=40)],render_kw={"placeholder": "Cartography"})
    motto = StringField('Motto', validators=[DataRequired(), Length(max=120)],render_kw={"placeholder": "Let there be light"})
    
    submit = SubmitField('Create')
    
    def validate_department_title(self, department_title):
        department = Department.query.filter_by(title = department_title.data).first()
        if not department:
            raise ValidationError('This department doesn\'t exist.')

    def validate_title(self, title):
        department = Department.query.filter_by(title = title.data).first()
        division = Department.query.filter_by(title = title.data).first()
        if department:
            raise ValidationError('This department allready exist.')



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
            raise ValidationError('A division already exist with that name!')
        
        test1 = Department.query.filter_by(title = title.data).first()
        test2 = Department.query.filter_by(id = self.department_id.data).first()
        if test1 and test1 != test2:
            raise ValidationError('Cannot be the same as a department that exist!')
        
    def validate_color(self, color):
        test1 = Department.query.filter_by(color = color.data).first()
        test2 = Department.query.filter_by(id = self.department_id.data).first()
        if test1 and test1 != test2:
            raise ValidationError('Cannot be the same color!')
        
    
class Div_Form(FlaskForm):
    
    division_id = HiddenField('Field', validators= [DataRequired()] )
    
    title = StringField('Title', validators= [DataRequired()] )
    
    motto = StringField('Motto', validators=[DataRequired(), Length(max=120)],render_kw={"placeholder": "Let there be light"})
    
    update = SubmitField('Update')
    
    def validate_department_id(self, division_id):
        test = Division.query.filter_by(id = division_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_title(self, title):
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        
        test1 = Division.query.filter_by(title = title.data).first()
        test2 = Division.query.filter_by(id = self.division_id.data).first()
        if test1 and test1 != test2:
            raise ValidationError('Cannot be the same as a division that exist!')
