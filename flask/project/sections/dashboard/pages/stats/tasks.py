from project import db, bcrypt, discord
from project.models import Funding
from project import db, scheduler
import datetime
import json

import pathlib




#@scheduler.task("interval",id="parse_fund", minutes=  , max_instances=1)
def get_funding_stats():
    
    def return_date(item):
        return item.date
    
    
    json_data = {}
    json_data['data'] = {}
    json_data['data']['1'] = []
    json_data['data']['2'] = []
    json_data['data']['3'] = []
    json_data['data']['4'] = []
    json_data['data']['5'] = []
    
    now = datetime.datetime.utcnow()
    current = Funding.query.order_by(Funding.date.desc()).first()
    day_ago = now - datetime.timedelta(days = 1)
    yesterday = Funding.query.filter(Funding.date >= day_ago).order_by(Funding.date.asc()).first()
    
    if yesterday:
    
        json_data['current_stats'] = {}
        json_data['current_stats']['fund'] = current.fund
        json_data['current_stats']['daily_fund'] = current.fund - yesterday.fund
        json_data['current_stats']['citizens'] = current.citizens
        json_data['current_stats']['daily_citizens'] = current.citizens - yesterday.citizens
        json_data['current_stats']['current_time'] = datetime.datetime.now().strftime('%d/%m/%Y %H:%M:%S %Z')
    
    else:
        
        json_data['current_stats'] = {}
        json_data['current_stats']['fund'] = 0
        json_data['current_stats']['daily_fund'] = 0
        json_data['current_stats']['citizens'] = 0
        json_data['current_stats']['daily_citizens'] = 0
        json_data['current_stats']['current_time'] = 0
    
    for time in range(1, 6):
    
        now = datetime.datetime.utcnow()
        day_ago = now - datetime.timedelta(days = 1)
        week_ago = now - datetime.timedelta(weeks = 1)
        month_ago = now - datetime.timedelta(weeks = 4)
        year_ago = now - datetime.timedelta(days = 365.25)
        
        fundings = Funding.query.order_by(Funding.date)
        year =  fundings.filter(Funding.date >= year_ago)
        month =  year.filter( Funding.date >= month_ago)
        week =  month.filter( Funding.date >= week_ago)
        day = week.filter( Funding.date >= day_ago).all()
        
        week = week.all()
        month = month.all()
        year = year.all()
        
        data = []
        
        if time == 2:
            need_citizen = True
            need_fund = True
            current_day = 0
            for item in week:
                if item not in data and current_day != item.date.day:
                    if need_fund and item.fund != 0 and item.fund != None:
                        data.append(item)
                        need_fund = False
                        
                        if need_citizen and item.citizens != 0 and item.citizens != None:
                            need_citizen = False
                        
                    if need_citizen and item.citizens != 0 and item.citizens != None:
                        need_citizen = False
                        if item not in data:
                            data.append(item)
                            
                    if not need_citizen and not need_fund:
                        current_day = item.date.day
                        need_citizen = True
                        need_fund = True
        elif time == 3:
            need_citizen = True
            need_fund = True
            current_week = 0
            for item in month:
                if item not in data and current_week != item.date.strftime('%U'):
                    if need_fund and item.fund != 0 and item.fund != None:
                        data.append(item)
                        need_fund = False
                        
                        if need_citizen and item.citizens != 0 and item.citizens != None:
                            need_citizen = False
                        
                    if need_citizen and item.citizens != 0 and item.citizens != None:
                        need_citizen = False
                        if item not in data:
                            data.append(item)
                            
                    if not need_citizen and not need_fund:
                        current_week = item.date.strftime('%U')
                        need_citizen = True
                        need_fund = True
            
        elif time == 5:
            
            need_citizen = True
            need_fund = True          
            current_month = 0
            for item in fundings:
                if item not in data and current_month != item.date.month:
                    if need_fund and item.fund != 0 and item.fund != None:
                        data.append(item)
                        need_fund = False
                        
                        if need_citizen and item.citizens != 0 and item.citizens != None:
                            need_citizen = False
                        
                        
                    if need_citizen and item.citizens != 0 and item.citizens != None:
                        need_citizen = False
                        if item not in data:
                            data.append(item)
                            
                    if not need_citizen and not need_fund:
                        current_month = item.date.month
                        need_citizen = True
                        need_fund = True
                        
        elif time == 4:
            
            need_citizen = True
            need_fund = True          
            current_month = 0
            for item in year:
                if item not in data and current_month != item.date.month:
                    if need_fund and item.fund != 0 and item.fund != None:
                        data.append(item)
                        need_fund = False
                        
                        if need_citizen and item.citizens != 0 and item.citizens != None:
                            need_citizen = False
                        
                    if need_citizen and item.citizens != 0 and item.citizens != None:
                        need_citizen = False
                        if item not in data:
                            data.append(item)
                            
                    if not need_citizen and not need_fund:
                        current_month = item.date.month
                        need_citizen = True
                        need_fund = True
        
        else:
            
            data = day
        
            
        data.sort(key= return_date)
        
        for idx , element in enumerate(data):
            if idx > 0 :
                for i in range(1, 3 ):
                    if data[idx - i].fund > 10 and element.fund > 0:
                        element.fund_delta = element.fund - data[idx - i].fund
                        break
                
                for i in range( 1, 3 ):
                    if data[idx - i].citizens > 10 and element.citizens > 0 :
                        element.citizen_delta = element.citizens - data[idx - i].citizens
                        break
            
            if not hasattr(element, 'fund_delta'):
                element.fund_delta = 0
            if not hasattr(element, 'citizen_delta'):
                element.citizen_delta = 0
            
        for item in data:
            json_data['data'][str(time)].append({
                'fund': item.fund if item.fund != 0 else None,
                'fund_delta': item.fund_delta if item.fund_delta != 0 else None ,
                'citizens': item.citizens if item.citizens != 0 else None,
                'citizens_delta': item.citizen_delta if item.citizen_delta != 0 else None,
                'date': item.date.strftime('%s')
            })
            
            
        
    with open(str(pathlib.Path(__file__).parent.resolve())+'/temp_data.json', 'w') as outfile:
        json.dump(json_data, outfile , indent=4)