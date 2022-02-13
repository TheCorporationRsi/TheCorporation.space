import requests
import threading
from bs4 import BeautifulSoup as BS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from bs4 import Tag
import re
import time
import pathlib


DEFAULT_RSI_URL = 'https://robertsspaceindustries.com'

chrome_options = Options()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')
chrome_options.add_argument('--disable-gpu')



    


class RSI_funding ():

    def __init__(self):
        self.link = 'https://robertsspaceindustries.com/funding-goals'
        driver = webdriver.Chrome(chrome_options=chrome_options)
        driver.get(self.link)
        find_element = threading.Event
        
        def find_fund():
            x = 0
            while(x == 0):
                time.sleep(2)
                page = driver.page_source
                soup = BS(page, 'html.parser')
                try:
                    fund = int(soup.find("div", {"class": "funds-raised"}).find("div", {"class": "digits"}).string.replace(',', ''))
                    
                    if fund:
                        x = 1
                        find_element.set()
                except:
                    return("No loaded")
        
        thread = threading.Thread(target=find_element)
        thread.start()   
        find_fund()
    
        page = driver.page_source
        

        soup = BS(page, 'html.parser')
        self.fund = int(soup.find("div", {"class": "funds-raised"}).find("div", {"class": "digits"}).string.replace(',', ''))
        self.citizens = int(soup.find("div", {"class": "fans"}).find("div", {"class": "digits"}).string.replace(',', ''))
        print(self.fund)
        print(self.citizens)
        driver.quit()

# RSI_account(RSI_handle="Cyber-Dreamer")

# print(str(RSI_account(RSI_handle="ShiNo0By").corp_member()))
#print(RSI_funding().fund)