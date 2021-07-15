import requests
from bs4 import BeautifulSoup as BS
from bs4 import Tag
import re

DEFAULT_RSI_URL = 'https://robertsspaceindustries.com'


class RSI_account ():

    def __init__(self, RSI_handle):
        self.link = DEFAULT_RSI_URL+'/citizens/' + RSI_handle
        org_link = self.link + '/organizations'
        page = requests.get(self.link)
        org_page = requests.get(org_link)
        soup = BS(page.content, 'html.parser')
        org_soup = BS(org_page.content, 'html.parser')

        try:
            name = soup.find("div", {"class": "profile"}).find("div", {"class": "info"}).find_all("p")
            self.RSI_handle = name[1].find("strong").string
            self.Moniker = name[0].find("strong").string
            print("RSI_handle = " + self.RSI_handle)
            print("Moniker = " + self.Moniker)
            if self.RSI_handle.lower() != RSI_handle.lower():
                return None
        except:
            print("Wrong page!")
            return None

        try:
            self.ORGS = []
            orgs_list = org_soup.find_all("div", {"class": "org"})
            for org in orgs_list:
                self.ORGS.append(org.find("div", {"class": "info"}).find_all( "p", {"class": "entry"})[1].find("strong", {"class": "value"}).string)
            print("ORGS = " + str(self.ORGS))
        except:
            print("No ORGS!")
            org = None
            return None

        try:
            main_org = soup.find("div", {"class": "main-org"}).find("div", {"class": "info"}).find_all("p")
            self.main_org = main_org[1].find("strong").string
            self.org_rank = main_org[2].find("strong").string
            print("Main ORG = " + self.main_org)
        except:
            print("No ORG!")
            self.main_org = None

        self.Rank = name[2].find("span", {"class": "value"}).string

        image = soup.find("div", {"class": "thumb"}).find("img")["src"]
        self.image_link = DEFAULT_RSI_URL+image

        citizen = soup.find("p", {"class": "citizen-record"}).find("strong").string
        self.citizen = re.sub("[^0-9]", "", citizen)
        print("Citizen No. = " + self.citizen)

        info = soup.find_all("div", {"class": "left-col"})[1].find("div", {"class": "inner"}).find_all("p")

        self.email = None
        try:
            bio = soup.find("div", {"class": "bio"}).find("div")
            self.bio = bio.text
            self.email = re.search(r'[\w\.-]+@[\w\.-]+', bio.text).group(0)
        except:
            self.bio = None

        self.join_date = info[0].find("strong").string

        if len(info) == 3:
            self.location = info[1].find(
                "strong").string.replace(',', ' ').split()
            self.language = info[2].find(
                "strong").string.replace(',', ' ').split()
        elif len(info) == 2:
            self.language = info[1].find(
                "strong").string.replace(',', ' ').split()

    def corp_member(self):
        if self.main_org == "CORP":
            return True
        elif 'CORP' in self.ORGS:
            return True
        else:
            return False

    def confirm_email(self, email):
        if self.email.lower() == email.lower():
            return True
        else:
            return False
    
    def has_json(self):
        
        json = {
            'Link': self.link,
            'RSI_handle': self.RSI_handle, 
            'Moniker': self.Moniker,
            'citizen_code': self.citizen,
            'Email': self.email,
            'Join_date': self.join_date,
            'Main_Org': self.main_org,
            'Orgs': [],
            'image': self.image_link
            
        }
        for org in self.ORGS:
            json['Orgs'].append({
                'title': org
            })
        return json


RSI_account(RSI_handle="Cyber-Dreamer")

print(str(RSI_account(RSI_handle="ShiNo0By").corp_member()))
