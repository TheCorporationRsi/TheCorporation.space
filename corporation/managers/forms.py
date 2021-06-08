from flask_wtf import FlaskForm, Form
from wtforms import StringField, SubmitField, TextAreaField, SelectField, HiddenField, RadioField, FileField, FieldList, FormField, IntegerField
from flask_wtf.file import FileField, FileAllowed
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
    
class Div_Form(FlaskForm):
    
    division_id = HiddenField('Field', validators= [DataRequired()] )
    
    title = StringField('Title', validators= [DataRequired()] )
    

    update = SubmitField('Update')
    
    def validate_department_id(self, division_id):
        test = Division.query.filter_by(id = division_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_title(self, title):
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Allready exist!')
        
        test = Division.query.filter_by(title = title.data).first()
        test2 = Division.query.filter_by(id = self.division_id.data, title = title.data).first()
        if test and not test2:
            raise ValidationError('Cannot be the same as a division that exist!')


class Role_edit_Form(FlaskForm):
    
    role_id = HiddenField('Field', validators= [DataRequired()] )
    
    title = StringField('Title', validators= [DataRequired()] )
    

    update = SubmitField('Update')
    
    def validate_role_id(self, role_id):
        test = Role.query.filter_by(id = role_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_title(self, title):
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same name as a department!')
        
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same name as a department!')
        
        test = Role.query.filter_by(title = title.data).first()
        test2 = Role.query.filter_by(id = self.role_id.data, title = title.data).first()
        if test and not test2:
            raise ValidationError('Cannot be the same as a role that exist!')


class Role_edit_color_Form(FlaskForm):
    
    
    role_id = HiddenField('Field', validators= [DataRequired()] )
    
    title = StringField('Title', validators= [DataRequired()] )
    
    color = StringField('Color', validators= [DataRequired()] )
    
    rule = RadioField('rule', validators= [DataRequired()], choices=[('0','admin'),('1','managers'),('2','self-asign')])

    update = SubmitField('Update')
    
    def validate_role_id(self, role_id):
        test = Role.query.filter_by(id = role_id.data).first()
        if not test:
            raise ValidationError('Something went wrong!')
    
    def validate_title(self, title):
        test = Department.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same name as a department!')
        
        test = Division.query.filter_by(title = title.data).first()
        if test:
            raise ValidationError('Cannot be the same name as a department!')
        
        test = Role.query.filter_by(title = title.data).first()
        test2 = Role.query.filter_by(id = self.role_id.data, title = title.data).first()
        if test and not test2:
            raise ValidationError('Cannot be the same as a role that exist!')



class Detail_sections_form(Form):
    template_id = HiddenField("image", validators=[DataRequired()])
    title1 = StringField('Title', validators= [DataRequired()] )
    title2 = StringField('Title', validators= [DataRequired()] )
    text = TextAreaField('Message', validators=[DataRequired(), Length(max=100)])
    background_image = FileField('Division list background', validators=[FileAllowed(['jpg','jpeg', 'png'])])

class Header_images(Form):
    image_id = HiddenField("image", validators=[DataRequired()])
    background_image = FileField('Division list background', validators=[FileAllowed(['jpg','jpeg', 'png'])])

class Department_webpage_form(FlaskForm):
    department_id = HiddenField("Division", validators=[DataRequired()])
    div_background = FileField('Division list background', validators=[FileAllowed(['jpg','jpeg', 'png'])])
    
    header_images = FieldList(FormField(Header_images), min_entries=0)
    detail_sections = FieldList(FormField(Detail_sections_form), min_entries=0)

    update_dep = SubmitField('Update')
