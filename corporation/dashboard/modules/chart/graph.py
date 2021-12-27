from flask import render_template, request, Blueprint, jsonify
from corporation.models import Post, User, Department, Division, Funding
from flask_login import current_user, login_required
from corporation.data.scraping import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from corporation import db
import json

from corporation.dashboard.modules import modules


@modules.route('/chart/funding/graph/<int:time>')
def funding_chart(time = 1):
    ''' 
    1: day
    2: week
    3: month
    4: year
    5: all time
    
    '''
    with open('/home/cyberdreamer/website/corp/corporation/dashboard/pages/stats/temp_data.json') as json_file:
        data = json.load(json_file)
        
        list_funding = data['data']['1']
        
        if time > 1:
            list_funding += data['data']['2']
        if time > 2:
            list_funding += data['data']['3']
        if time > 3:
            list_funding += data['data']['4']
        if time > 4:
            list_funding += data['data']['5']
            
        def return_date(item):
            return item['date']
            
        list_funding.sort(key= return_date)
    
    return render_template('dashboard/modules/charts/funding_chart.html', data = json.dumps(list_funding), time = time)