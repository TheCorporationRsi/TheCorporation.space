
from corp_system.models import Inf_Auction

from corp_system import db

from datetime import datetime, timedelta

import pytest


def test_Inf_Auction_creation(client, new_user):
    # Create a department

    # Assert that the retrieved department matches the created department
    auction = Inf_Auction(end_time=(datetime.now() + timedelta(days=7)), starting_price= 100, item="Test Item", item_holder=new_user.inf_account)
    db.session.add(auction)
    db.session.commit()
    
    assert Inf_Auction.query.filter_by(item="Test Item").first() is not None
    assert auction.end_time < datetime.now() + timedelta(days=7)
    assert auction.starting_price == 100
    assert auction.item == "Test Item"
    assert auction.item_holder == new_user.inf_account
    assert auction.current_price == 99
    assert auction.bets == []
    assert auction.prize_claimed == False
    assert auction.highest_bidder == None

def test_Inf_Auction_bet(client, new_user, new_user2, new_department):
    # Create a department
    
    new_user.inf_account.add_influence(amount=105, department=new_department)
    new_user2.inf_account.add_influence(amount=105, department=new_department)

    # Assert that the retrieved department matches the created department
    auction = Inf_Auction(end_time=datetime.now(), starting_price= 100, item="Test Item", item_holder=new_user.inf_account)
    auction2 = Inf_Auction(end_time=(datetime.now() + timedelta(days=7)), starting_price= 50, item="Test Item", item_holder=new_user.inf_account)
    db.session.add(auction)
    db.session.add(auction2)
    db.session.commit()
    
    with pytest.raises(ValueError, match="Auction has already ended"):
        auction.bet(100, new_user)
        
    auction.end_time=(datetime.now() + timedelta(days=7))
    db.session.commit()

    with pytest.raises(ValueError, match="Bet amount is nit high enough"):
        auction.bet(99, new_user)
        
    with pytest.raises(ValueError, match="User does not have enough influence left of this type to bet"):
        auction.bet(200, new_user)
        
    auction.bet(100, new_user)
        
    with pytest.raises(ValueError, match="User does not have enough influence left of this type to bet"):
        auction2.bet(50, new_user)
    
    auction.bet(101, new_user2)
    auction2.bet(50, new_user)
        
    