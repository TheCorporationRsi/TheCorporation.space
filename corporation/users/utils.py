import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from corporation import mail
import requests


def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(current_app.root_path, 'static/profile_pics', picture_fn)
    
    output_size= (125,125)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)
    
    return picture_fn




def send_reset_email(user):
    token = user.get_reset_token()
    msg = Message('Password Reset Request', sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To reset your password, visit the following link:

    {url_for('users.reset_token', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    '''
    mail.send(msg)



def RSIverify(handle, code):
        link = 'https://robertsspaceindustries.com/citizens/'
        try:
            page = requests.get(link + handle)
            pagecontent = page.text
            handles_tart = pagecontent.find('<span class="label">Handle name</span>')
            handle_end = pagecontent.find('</p>', handles_tart)
            bio_start = pagecontent.find('<span class="label">Bio</span>')
            bio_end = pagecontent.find('</div>', bio_start)
            if bio_start < 0 or handles_tart < 0:
                return -1
        except:
            return -1

        if pagecontent.find(code, bio_start, bio_end) > 0:
            return 1

        elif bio_start > -1:
            return 0
        
        else:
            return -1
