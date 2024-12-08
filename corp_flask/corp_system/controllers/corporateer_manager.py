from corp_system.models import Influence, User, Inf_Rank, UserRole, Inf_Tribute
from corp_system import db
from datetime import datetime, timedelta

from sqlalchemy import asc, func


class CorporateerManager:

    @staticmethod
    def corporateers_list():
        
        corp_list= []
        # Add the given amount of tribute to the user's lifetime influence
        corporateers = User.query.filter_by(CORP_confirmed=True).all()
        for user in corporateers:
            corp_list.append({
                'RSI_handle': user.RSI_handle,
                'RSI_moniker': user.RSI_moniker,
                'picture': user.image_link,
            })
            
        return corp_list
    
    @staticmethod
    def get_member(RSI_handle):
        
        # Add the given amount of tribute to the user's lifetime influence
        corporateer = User.query.filter(func.lower(User.RSI_handle) == func.lower(RSI_handle)).filter_by(CORP_confirmed=True).first()
        if not corporateer:
            raise ValueError("User not found")
        
        return {
                'RSI_handle': corporateer.RSI_handle,
                'RSI_moniker': corporateer.RSI_moniker,
                'RSI_number': corporateer.RSI_number,
                'image_link': corporateer.image_link,
                'orgs': corporateer.orgs,
        }
        
        