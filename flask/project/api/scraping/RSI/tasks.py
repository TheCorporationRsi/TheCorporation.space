from project import db, bcrypt, discord, mail
from project.models import Funding
from project import db, scheduler
import datetime
from project.sections.dashboard.pages.stats.tasks import get_funding_stats
from flask_mail import Message
from project.api.scraping.RSI.funding import RSI_funding
import pathlib


@scheduler.task("cron", id="get_fund", hour='*' , max_instances=1)
def get_funding_stats_task():
    stats = RSI_funding()
    element = Funding(fund = stats.fund, citizens = stats.citizens)
    now = datetime.datetime.utcnow()
    day_ago = now - datetime.timedelta(minutes= 30)
    last_data = Funding.query.filter( Funding.date >= day_ago).first()
    if not last_data:
        db.session.add(element)
        db.session.commit()
        get_funding_stats()
        print("Got the SC stats")


@scheduler.task("cron", id="backup_data", day='*', max_instances=1)
def send_backup_email():
    msg = Message('RSI stats backup', sender='cyberdreamercorp@gmail.com', recipients=["gata23laroche@gmail.com"])
    msg.body = f'''This is the backup of the RSI stats at {datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")}
    '''
    with open(str(pathlib.Path(__file__).parent.parent.parent.parent.resolve())+'/databases/funding.db', 'rb') as db_file:
        msg.attach("funding.db", "application/x-sqlite3", db_file.read())
    with open(str(pathlib.Path(__file__).parent.parent.parent.parent.resolve())+'/databases/user.db', 'rb') as db_file:  
        msg.attach("user.db", "application/x-sqlite3", db_file.read())
    print("sent!")
    with scheduler.app.app_context():
        mail.send(msg)


