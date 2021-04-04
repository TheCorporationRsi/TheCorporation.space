from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField
from wtforms.ext.sqlalchemy.fields import QuerySelectField
from wtforms.validators import DataRequired
from corporation.models import Post, User, Role, Division, User_Role, Departement
from corporation import db



class Departement_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    submit = SubmitField('Create')
    
class Division_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    departement = QuerySelectField(query_factory=lambda: Departement.query.all(), get_label='title', allow_blank=False, blank_text=(u'Select a departement'), get_pk=lambda x: 'id')
    
    submit = SubmitField('Create')
    

class Role_Form(FlaskForm):
    
    title = StringField('Title', validators= [DataRequired()] )
    
    division = QuerySelectField(query_factory=lambda: Division.query.all(), get_label='title', allow_blank=False, blank_text=(u'Select a division'), get_pk=lambda x: 'id')
    
    submit = SubmitField('Create')
