from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division, Funding
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db
import json

from corporation.dashboard.modules import modules

class funding_table_data():
    "This is a person class"
    data = [[],[],[],[],[],[]]
    
    time = [0,0,0,0,0,0]

@modules.route('/chart/funding/table/<int:time>')
def funding_table(time = 1):
    ''' 
    1: day
    2: week
    3: month
    4: year
    5: all time
    
    '''
    
    def return_date(item):
        return item.date
    
    one_hour = datetime.datetime.now() - datetime.timedelta(hours = 1)
    global funding_table_data
    if not funding_table_data.time[time] == 0 and funding_table_data.time[time] > one_hour:
        data = funding_table_data.data[time]
        
        return render_template('dashboard/modules/charts/funding_table.html', data = data, time = time)
    
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
                if data[idx - i].fund > 10:
                    element.fund_delta = element.fund - data[idx -1].fund
                    break
            
            for i in range( 1, 3 ):
                if data[idx - i].citizens > 10:
                    element.citizen_delta = element.citizens - data[idx -1].citizens
                    break
        
        if not hasattr(element, 'fund_delta'):
            element.fund_delta = 0
        if not hasattr(element, 'citizen_delta'):
            element.citizen_delta = 0
            
    funding_table_data.data[time] = data
    funding_table_data.time[time] = datetime.datetime.now()
    
    
    return render_template('dashboard/modules/charts/funding_table.html', data = data, time = time)