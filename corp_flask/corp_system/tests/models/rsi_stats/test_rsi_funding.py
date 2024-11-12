import pytest
from datetime import datetime
from corp_system.models.rsi_stats.funding import Funding

from corp_system import db



def test_funding(client):
    
    
    time = datetime.now()
    
    funding = Funding(citizens=3000, fund=1000, date=time)
    
    db.session.add(funding)
    db.session.commit()
    
    
    test_fund = Funding.query.filter_by(citizens=3000).first()
    assert test_fund == funding
    assert test_fund.citizens == 3000
    assert test_fund.fund == 1000
    
