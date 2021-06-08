import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from corporation import mail
import requests
from bs4 import BeautifulSoup as bs


def save_background(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(
        current_app.root_path, 'static\department_background', picture_fn)

    i = Image.open(form_picture)
    i.save(picture_path)

    return picture_fn

def save_logo(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(
        current_app.root_path, 'static\department_background', picture_fn)

    output_size = (1000, 1000)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn