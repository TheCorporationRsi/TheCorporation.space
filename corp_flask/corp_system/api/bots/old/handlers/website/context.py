from project.models import User
from flask_login import current_user
from flask import flash


class website_ctx():
    
    type = "website"
    
    
        
    @property
    def user(self):
        return current_user
    
    def send(self, message):
        flash(message, "success")
    