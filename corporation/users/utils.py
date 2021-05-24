import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from corporation import mail
import requests
from bs4 import BeautifulSoup as bs


def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(
        current_app.root_path, 'static/profile_pics', picture_fn)

    output_size = (500, 500)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn


def send_reset_email(user):
    token = user.get_reset_token()
    msg = Message('Password Reset Request',
                  sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To reset your password, visit the following link:

    {url_for('users.reset_token', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    '''
    mail.send(msg)


def send_confirmation_email(user):
    token = user.get_confirmation_token()
    msg = Message('Email confirmation for Corporation account',
                  sender='cyberdreamercorp@gmail.com', recipients=[user.email])
    msg.body = f'''To confirm your account, visit the following link:

    {url_for('users.confirm_email', token= token, _external=True)}

    If you did not make this request then simply ignore this email and no change will be made
    
    This email is good for 48h, after that, you may request a new email.
    '''
    mail.send(msg)


""" def RSIverify(handle, code):
    link = 'https://robertsspaceindustries.com/citizens/'
    try:
        page = requests.get(link + handle)
        print(page)
        pagecontent = page.text
        handles_start = pagecontent.find(
            '<span class="label">Handle name</span>')
        handle_end = pagecontent.find('</p>', handles_start)
        Org_start = pagecontent.find("<strong class=\"value data6\">")
        Org_start = pagecontent.find("</strong>", Org_start)
        bio_start = pagecontent.find('<span class="label">Bio</span>')
        bio_end = pagecontent.find('</div>', bio_start)
        if bio_start < 0 or handles_start < 0:
            return -1
    except:
        return -1

    if code == None:
        if pagecontent.find("CORP", bio_start, bio_end) > 0:
            return 2

    elif pagecontent.find(code, bio_start, bio_end) > 0:
        if pagecontent.find("CORP", bio_start, bio_end) > 0:
            return 2
        else:
            return 1

    elif bio_start > -1:
        return 0

    else:
        return -1


def fetch_citizen(name, url=DEFAULT_RSI_URL, endpoint='/citizens', skip_orgs=False):
    result = {}
    url = url.rstrip('/')
    citizen_url = "{}/{}/{}".format(url.rstrip('/'), endpoint.strip('/'), name)
    orgapiurl = '{}/{}'.format(url.rstrip('/'), 'api/orgs/getOrgMembers')

    page = requests.get(citizen_url, headers=None)
    print(page)
    
    if page.status_code == 404:
        print(f'Received a 404 Error Code from query to {citizen_url}.')
        
    if page.status_code == 200:
        
        soup = bs(page.text, features='lxml')
        _ = [_.text for _ in soup.select(".info .value")[:3]]
        result['username'] = get_item(_, 0, '')
        result['handle'] = get_item(_, 1, '')
        result['title'] = get_item(_, 2, '')
        result['title_icon'] = get_item(soup.select(".info .icon img"), 0, '')
        
        if result['title_icon']:
            result['title_icon'] = '{}/{}'.format(url,result['title_icon']['src'])
            
        result['avatar'] = "{}/{}".format(url, soup.select('.profile .thumb img')[0]['src'].lstrip('/'))
        result['url'] = citizen_url

        if soup.select('.profile-content .bio'):
            result['bio'] = soup.select('.profile-content .bio')[0].text.strip('\nBio').strip()
            
        else:
            result['bio'] = ''
        result['citizen_record'] = soup.select('.citizen-record .value')[0].text
        
        try:
            result['citizen_record'] = int(result['citizen_record'][1:])
        except:
            print(
                'Encountered unexpceted citizen_record. Making citizen_record 1000000000.')
            result['citizen_record'] = 1000000000
            pass

        _ = {_.select_one('span').text:
            _re.sub(r'\s+', ' ', _.select_one('.value').text.strip()).replace(' ,', ',')for _ in soup.select('.profile-content > .left-col .entry')}
        
        result['enlisted'] = get_item(_, 'Enlisted', '')
        result['location'] = get_item(_, 'Location', '')
        result['languages'] = get_item(_, 'Fluency', '')
        result['languages'] = result['languages'].replace(',', '').split()

        if not skip_orgs:
            orgs_page = requests.get("{}/organizations".format(citizen_url))
            
            if orgs_page.status_code == 200:
                
                orgsoup = bs(orgs_page.text, features='lxml')
                result['orgs'] = []
                for org in orgsoup.select('.orgs-content .org'):
                    orgname, sid, rank = [_.text for _ in org.select('.info .entry .value')]
                    
                    if orgname[0] == '\xa0':
                        orgname = sid = rank = 'REDACTED'

                    roles = []
                    r = requests.post( orgapiurl, data={'symbol': sid, 'search': name})
                    if r.status_code == 200:
                        r = r.json()
                        
                        if r['success'] == 1:
                            apisoup = bs(r['data']['html'], features='lxml')
                            roles = [_.text for _ in apisoup.select(
                                '.rolelist .role')]

                    orgdata = {
                        'name': orgname,
                        'sid': sid,
                        'rank': rank,
                        'roles': roles,
                    }
                    
                    try:
                        orgdata['icon'] = '{}/{}'.format( url, org.select('.thumb img')[0]['src'].lstrip('/'))
                    except IndexError:
                        pass

                    result['orgs'].append(orgdata)
    return result
 """