import requests
from bs4 import BeautifulSoup as BS
from bs4 import Tag
import re

DEFAULT_RSI_URL = 'https://robertsspaceindustries.com'

class RSI_account ():
    
    def __init__(self, RSI_handle):
        self.link =  DEFAULT_RSI_URL+'/citizens/'+ RSI_handle
        page = requests.get(self.link)
        soup = BS(page.content, 'html.parser')
        name = soup.find("div", {"class": "info"}).find_all("p")
        image = soup.find("div", {"class": "thumb"}).find("img")["src"]
        citizen = soup.find("p", {"class": "citizen-record"}).find("strong").string
        org = soup.find("div", {"class": "main-org"}).find("div", {"class": "info"}).find_all("p")
        info = soup.find_all("div", {"class": "left-col"})[1].find("div", {"class": "inner"}).find_all("p")
        
        try:
            bio = soup.find("div", {"class": "bio"}).find("div")
            self.bio = bio.text
            self.email = re.search(r'[\w\.-]+@[\w\.-]+', bio.text).group(0)
        except:
            self.bio = None
        
        self.citizen = re.sub("[^0-9]", "", citizen)
        self.image_link = DEFAULT_RSI_URL+image
        self.Moniker = name[0].find("strong").string
        self.RSI_handle = name[1].find("strong").string
        self.Rank = name[2].find("span", {"class": "value"}).string
        self.main_org = org[1].find("strong").string
        self.org_rank = org[2].find("strong").string
        self.join_date = info[0].find("strong").string
        if len(info) == 3:
            self.location = info[1].find("strong").string.replace(',',' ').split()
            self.language = info[2].find("strong").string.replace(',',' ').split()
        elif len(info) == 2:
            self.language = info[1].find("strong").string.replace(',',' ').split()

    def corp_member(self):
        if self.main_org == "CORP":
            return True
        else:
            return False
    
    def confirm_email(self, email):
        if self.email.lower() == email.lower():
            return True
        else:
            return False
    


user = RSI_account(RSI_handle = "cyber-dreamer2")

print(user.link)
print(user.citizen)
print(user.image_link)
print(user.Moniker)
print(user.RSI_handle)
print(user.Rank)
print(user.main_org)
print(user.org_rank)
print(user.language)


print(user.corp_member())

try:
    print(user.email.lower())
    print(user.bio)
    print(user.confirm_email(email= "gata23laroche_@hotmail.com"))
    print(user.location)
except:
    print("error")
