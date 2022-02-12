from project import db, bcrypt, discord
from project.models import User, Role, Influence
from project import db, scheduler
import datetime


@scheduler.task("cron",id="send_tribute",day_of_week = "fri", max_instances=1)
def send_weekly_tribute():
    users = User.query.all()
    for user in users:
        if user.corp_confirmed:
            user.receive_weekly_tribute()
    print("Weekly tribute have been distibuted!")
    
@scheduler.task("cron",id="send_tribute2",day= "*", max_instances=1)
def send_weekly_tribute2():
    users = User.query.all()
    for user in users:
        if user.corp_confirmed:
            user.receive_weekly_tribute()
    print("Weekly tribute have been distibuted!")

@scheduler.task("interval",id="downgrade_influence", days = 1 , max_instances=1)
def downgrade_inlfuence():
    now = datetime.datetime.now()
    influences = Influence.query.filter( (now - Influence.date_added).days > 180, Influence.department > 0  ).all()
    for influence in influences:
        if influence.division > 0:
            influence.division = 0
        elif influence.department > 0:
            influence.department = 0
        influences.date_added = now
    
    db.session.commit()
    print("Inlfuence has been downgraded!")
