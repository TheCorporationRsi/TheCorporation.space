import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from corporation import mail
import requests
from bs4 import BeautifulSoup


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
    
def send_confirmation_email(user):
    token = user.get_confirmation_token()
    msg = Message('Email confirmation for Corporation account', sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To confirm your account, visit the following link:

    {url_for('users.confirm_email', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    
    This email is good for 48h, after that, you may request a new email.
    '''
    mail.send(msg)



def RSIverify(handle, code):
        link = 'https://robertsspaceindustries.com/citizens/'
        try:
            page = requests.get(link + handle)
            print(page)
            pagecontent = page.text
            handles_start = pagecontent.find('<span class="label">Handle name</span>')
            handle_end = pagecontent.find('</p>', handles_start)
            Org_start = pagecontent.find("<strong class=\"value data6\">") 
            Org_start = pagecontent.find("</strong>", Org_start)
            bio_start = pagecontent.find('<span class="label">Bio</span>')
            bio_end = pagecontent.find('</div>', bio_start)
            if bio_start < 0 or handles_start < 0:
                return -1
        except:
            return -1

        if code == None:
            if pagecontent.find("CORP", bio_start, bio_end) > 0: 
                return 2
        
        elif pagecontent.find(code, bio_start, bio_end) > 0:
            if pagecontent.find("CORP", bio_start, bio_end) > 0:
                return 2
            else:
                return 1

        elif bio_start > -1:
            return 0
        
        else:
            return -1
