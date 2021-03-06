import os
import secrets
from PIL import Image
from flask import url_for, current_app, render_template
from flask_mail import Message
from project import mail
import requests
from bs4 import BeautifulSoup as bs
from project.models import User
from flask import flash

def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(
        current_app.root_path, 'static/profile_pics', picture_fn)

    output_size = (500, 500)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn


def send_reset_email(user):
    token = user.get_reset_token()
    msg = Message('Password Reset Request',
                  sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To reset your password, visit the following link:

    {url_for('security.reset_token', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    '''
    mail.send(msg)


def send_confirmation_email(user):
    token = user.get_security_token()
    msg = Message('Email confirmation for Corporation account',
                  sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To confirm your account, visit the following link:

    {url_for('security.confirm_email', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    
    This email is good for 48h, after that, you may request a new email.
    '''
    
    msg.html = render_template("emails/confirm_email_template.html", token = token)
    
    try:
        mail.send(msg)
    except:
        flash("Enable to send email at the moment, pls try later", "danger")
        return -1
