from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from corporation import db, bcrypt, discord
from corporation.models import User, Post
from corporation.users.forms import (RegistrationForm, LoginForm, UpdateAccountForm, RequestResetForm, ResetPasswordForm)
from corporation.users.utils import save_picture, send_reset_email
from flask_discord import requires_authorization


from flask import Blueprint

users = Blueprint('users', __name__)



@users.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = User(RSI_handle= form.RSI_handle.data, email= form.email.data, password= hashed_password)
        db.session.add(user)
        db.session.commit()
        flash(f'Your account has been created! You can now login.', 'success')
        return redirect(url_for('users.login'))
    return render_template("user/register.html", title = "Register", form = form)

@users.route("/discord/<int:type>")
def discord_login(type):
    if current_user.is_authenticated and type == 1:
        logout_user()
        return redirect(url_for('main.home'))
    
    return discord.create_session()

@users.route("/discord_callback")
def callback():
    if current_user.is_authenticated:
        discord.callback()
        user = discord.fetch_user()
        user_account = User.query.filter_by(RSI_handle= current_user.RSI_handle).first()
        user_account.discord_id = user.id
        user_account.discord_username = user.username+'#'+ user.discriminator
        db.session.commit()
        discord.revoke()
        return redirect(url_for('users.account'))
    
    try:
        discord.callback()
        user = discord.fetch_user()
        user_account = User.query.filter_by(discord_id= user.id).first()
    except: 
        return redirect(url_for("users.login"))
    
    if user_account:
        user_account.discord_username = user.username+'#'+ user.discriminator
        db.session.commit()
        discord.revoke()
        login_user(user_account, remember= False)
        return redirect(url_for('main.home'))
    
    else:
        discord.revoke()
        return redirect(url_for('users.register'))
    
    return redirect(url_for("main.home"))


@users.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email= form.email.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember= form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('main.home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
    return render_template("user/login.html", title = "Login", form = form)


@users.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('main.home'))

@users.route("/account", methods=['GET', 'POST'])
@login_required
def account():
    form = UpdateAccountForm()
    if form.validate_on_submit():
        if form.picture.data:
            picture_file= save_picture(form.picture.data)
            current_user.image_file = picture_file

        current_user.email = form.email.data
        db.session.commit()
        flash('Your account has been updated!', 'success')
        return redirect(url_for('users.account'))
    elif request.method == 'GET':
        form.email.data = current_user.email
    image_file = url_for('static', filename= 'profile_pics/'+ current_user.image_file )
    return render_template("user/account.html", title = "Account", image_file= image_file, form= form)



@users.route("/user/<string:username>")
def user_posts(username):
    page = request.args.get('page', 1, type=int)
    user = User.query.filter_by(RSI_handle=username).first_or_404()
    posts = Post.query.filter_by(author=user)\
        .order_by(Post.date_posted.desc())\
        .paginate(page=page, per_page=5)
    return render_template('social/user_posts.html', posts=posts, user=user)



@users.route("/reset_password", methods=['GET', 'POST'])
def reset_request():
    if current_user.is_authenticated:
        return redirect(url_for('main.home')) 

    form = RequestResetForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email = form.email.data).first()
        send_reset_email(user)
        flash('An email has been sent with instruction to reset your password', 'info')
        return redirect(url_for('users.login'))
    return render_template('user/reset_request.html', title= "Reset Password", form= form )



@users.route("/reset_password/<token>", methods=['GET', 'POST'])
def reset_token(token):
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    user = User.verify_reset_token(token)
    if user is None:
        flash('That is an invalid or expired token', 'warning')

    form = ResetPasswordForm()

    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user.password = hashed_password
        db.session.commit()
        flash(f'Your password has been updated! You can now login.', 'success')
        return redirect(url_for('users.login'))

    return render_template('user/reset_token.html', title= "Reset Password", form= form )




