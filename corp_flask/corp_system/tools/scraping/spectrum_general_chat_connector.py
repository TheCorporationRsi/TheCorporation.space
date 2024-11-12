import requests
import threading
from bs4 import BeautifulSoup as BS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from bs4 import Tag
import re
import time
import pathlib


DEFAULT_RSI_URL = 'https://robertsspaceindustries.com'


    


class RSI_funding():
    """
    A class for scraping funding information from the Roberts Space Industries website.
    """

    def __init__(self):
        self.link = 'https://robertsspaceindustries.com/api/stats/getCrowdfundStats'
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
            
        }
        payload = {'chart': "day", 'fans': True, 'funds': True, 'alpha_slots': True, 'fleet': True}
      
        page = requests.post(self.link, headers=headers, json=payload)
        data = page.json()
       
        self.fund = data['data']['funds']
        self.citizens = data['data']['fans']
        print(self.citizens)
        print(self.fund)

# RSI_account(RSI_handle="Cyber-Dreamer")

# print(str(RSI_account(RSI_handle="ShiNo0By").corp_member()))
#RSI_funding()