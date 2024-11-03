from corp_system import scheduler, db

from corp_system.models import Funding

from corp_system.tools.scraping.funding import RSI_funding

@scheduler.task('cron', id='collect_funding_data', hour='*')
def collect_funding_data():
    with scheduler.app.app_context():
    
        funding_stats = RSI_funding()
        
        funding = Funding(citizens=funding_stats.citizens, fund=funding_stats.fund)
        
        db.session.add(funding)
        db.session.commit()


@scheduler.task('cron', id='clean_funding_data', week='*')
def clean_funding_data():
    
    pass