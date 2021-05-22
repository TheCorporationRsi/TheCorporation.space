from corporation import db, bcrypt, discord
from corporation.models import User, Post, Role, Rolevsuser
from corporation import db, scheduler


#@scheduler.task("cron",id="send_tribute",day_of_week = "fri", max_instances=1)
def send_weekly_tribute():
    users = User.query.all()
    for user in users:
        user.receive_weekly_tribute()
    print("lol")
