from project import db, bcrypt, discord
from project.models import Funding
from project import db, scheduler
import datetime
from project.sections.dashboard.pages.stats.tasks import get_funding_stats

from project.api.scraping.RSI.funding import RSI_funding



@scheduler.task("cron", id="get_fund", hour='*' , max_instances=1)
def get_funding_stats_task():
    stats = RSI_funding()
    element = Funding(fund = stats.fund, citizens = stats.citizens)
    db.session.add(element)
    db.session.commit()
    get_funding_stats()
    print("Got the SC stats")