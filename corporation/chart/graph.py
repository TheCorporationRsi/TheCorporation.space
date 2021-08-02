from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division, Funding
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db
import json

from corporation.chart import chart

@chart.route('/chart/funding/graph/<int:time>')
def funding_chart(time = 1):
    ''' 
    1: day
    2: week
    3: month
    4: year
    5: all time
    
    '''
    
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
    
    data = day
    
    if time > 1:
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
    if time > 2:
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
        
    if time > 4:
        
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
                    
    elif time > 3:
        
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
                
    def return_date(item):
        return item.date
    
    data.sort(key= return_date)
    
    
    list_funding=[r.as_dict() for r in data]
    
    return render_template('dashboard/modules/charts/funding_chart.html', data = json.dumps(list_funding), time = time)