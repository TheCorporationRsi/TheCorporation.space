from flask import render_template, request, Blueprint, jsonify
from project.models import User, Department, Division, Funding
from flask_login import current_user, login_required
from project.api.scraping.RSI.account import RSI_account
from sqlalchemy import func, extract, and_
import datetime
from project import db
import json
import pathlib

from project.sections.dashboard.modules import modules

@modules.app_template_filter()
def epoch_to_date(epoch):
    return datetime.datetime.fromtimestamp(int(epoch)).strftime('%c')


@modules.route('/chart/funding/table/<int:time>')
def funding_table(time = 1):
    ''' 
    1: day
    2: week
    3: month
    4: year
    5: all time
    
    '''
    
    with open(str(pathlib.Path(__file__).parent.parent.parent.resolve())+'/pages/stats/temp_data.json') as json_file:
        json_data = json.load(json_file)
        
        data = json_data['data'][str(time)]
    
    return render_template('dashboard/modules/charts/funding_table.html', data = data, time = time)