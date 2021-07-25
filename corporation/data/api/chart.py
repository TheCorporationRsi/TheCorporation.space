from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division, Funding
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db

from corporation.data.api import data

@data.route('/data/fundings/chart_data')
def funding_chart():
    
    now = datetime.datetime.utcnow()
    week_ago = now - datetime.timedelta(weeks=1)
    
    fundings = Funding.query.order_by(Funding.date)
    year =  fundings.filter(extract('year', Funding.date) == now.year)
    month =  year.filter( extract('month', Funding.date) == now.month)
    week =  month.filter( Funding.date >= week_ago)
    day = week.filter( extract('day', Funding.date) == now.day).all()
    
    week = week.all()
    month = month.all()
    year = year.all()
    
    data = day
    
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
                if item not in data:
                    data.append(item)
                    
            if not need_citizen and not need_fund:
                current_day = item.date.day
                need_citizen = True
                need_fund = True
    
    
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
                if item not in data:
                    data.append(item)
                    
            if not need_citizen and not need_fund:
                current_week = item.date.strftime('%U')
                need_citizen = True
                need_fund = True
    
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
    return jsonify(list_funding)