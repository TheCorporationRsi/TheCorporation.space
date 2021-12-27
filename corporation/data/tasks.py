from corporation import db, bcrypt, discord
from corporation.models import Funding
from corporation import db, scheduler
import datetime
from corporation.dashboard.pages.stats.tasks import get_funding_stats

from corporation.data.scraping import RSI_funding



@scheduler.task("cron",id="get_fund", hour='*' , max_instances=1)
def get_funding_stats():
    stats = RSI_funding()
    element = Funding( fund = stats.fund, citizens = stats.citizens )
    db.session.add(element)
    
    
    
    db.session.commit()
    get_funding_stats()
    print("Got the SC stats")