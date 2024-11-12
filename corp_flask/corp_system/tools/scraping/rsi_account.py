import requests
from bs4 import BeautifulSoup as BS
import re

import aiohttp
import asyncio
from time import sleep

from .file_semaphore import FileSemaphore

import os



DEFAULT_RSI_URL = 'https://robertsspaceindustries.com'

def sync_get(url):
    async def fetch(session, url):
        async with session.get(url) as response:
            return await response.text()

    async def main(url):
        async with aiohttp.ClientSession() as session:
            content = await fetch(session, url)
            return content

    return asyncio.run(main(url))

import time
from requests.exceptions import HTTPError
class RSI_account:
    """
    Represents an RSI account.

    Attributes:
        link (str): The link to the RSI account.
        RSI_handle (str): The RSI handle of the account.
        Moniker (str): The moniker of the account.
        ORGS (list): The list of organizations the account belongs to.
        main_org (str): The main organization of the account.
        org_rank (str): The rank of the main organization.
        Rank (str): The rank of the account.
        image_link (str): The link to the account's image.
        citizen (str): The citizen number of the account.
        join_date (str): The join date of the account.
        location (list): The location of the account.
        language (list): The language of the account.
        bio (str): The bio of the account.

    Methods:
        corp_member(): Checks if the account is a member of the CORP organization.
        confirm_token(token): Confirms if the given token is present in the account's bio.
        as_json(): Returns the account information as a JSON object.
    """
    
    def fetch_information(self, RSI_handle):

        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
        }

        for attempt in range(self.max_retries):
            try:
                page = requests.get(self.link, headers=headers)
                org_page = requests.get(self.org_link, headers=headers)
                page.raise_for_status()
                org_page.raise_for_status()
                soup = BS(page.content, 'html.parser')
                org_soup = BS(org_page.content, 'html.parser')

                try:
                    name = soup.find("div", class_="profile").find("div", class_="info").find_all("p")
                    self.RSI_handle = name[1].find("strong").string
                    self.Moniker = name[0].find("strong").string
                    if self.RSI_handle.lower() != RSI_handle.lower():
                        print("Handle mismatch!")
                        return
                except Exception as e:
                    print(f"Error while fetching handle and moniker: {e}")
                    return

                try:
                    self.ORGS = []
                    orgs_list = org_soup.find_all("div", class_="org")
                    for org in orgs_list:
                        self.ORGS.append(org.find("div", class_="info").find_all("p", class_="entry")[1].find("strong", class_="value").string)
                except Exception as e:
                    print(f"Error while fetching organizations: {e}")
                    return

                try:
                    main_org = soup.find("div", class_="main-org").find("div", class_="info").find_all("p")
                    self.main_org = main_org[1].find("strong").string
                    self.org_rank = main_org[2].find("strong").string
                except Exception as e:
                    print(f"Error while fetching main organization: {e}")
                    return

                try:
                    self.Rank = name[2].find("span", class_="value").string
                    image = soup.find("div", class_="thumb").find("img")["src"]
                    self.image_link = f'{DEFAULT_RSI_URL}{image}'
                    citizen = soup.find("p", class_="citizen-record").find("strong").string
                    self.citizen = re.sub("[^0-9]", "", citizen)
                    print("Citizen No. = " + self.citizen)

                except Exception as e:
                    print(f"Error while fetching rank, image link, and citizen number: {e}")
                    return


                try:
                    info = soup.find_all("div", class_="left-col")[1].find("div", class_="inner").find_all("p")
                    self.join_date = info[0].find("strong").string

                    if len(info) == 3:
                        self.location = info[1].find("strong").string.replace(',', ' ').split()
                        self.language = info[2].find("strong").string.replace(',', ' ').split()
                    elif len(info) == 2:
                        self.language = info[1].find("strong").string.replace(',', ' ').split()
                except Exception as e:
                    print(f"Error while fetching join date, location, and language: {e}")

                try:
                    
                    bio = soup.find("div", class_="bio")
                    if bio:
                        bio = bio.find("div")
                        self.bio = bio.text
                    else:
                        print("Missing bio")
                    #self.email = re.search(r'[\w\.-]+@[\w\.-]+', bio.text)
                    #if self.email:
                    #    self.email = self.email.group(0)
                except Exception as e:
                    print(f"Error while fetching bio and email: {e}")
                    self.bio = None
                    
                break  # Exit the loop if the request was successful

            except HTTPError as e:
                if e.response.status_code == 429:  # Too Many Requests
                    print(f"Rate limit hit, retrying in {self.retry_delay} seconds...")
                    time.sleep(self.retry_delay)
                elif e.response.status_code == 403:  # Too Many Requests
                    print(f"access denied, retrying in {self.retry_delay} seconds...")
                    time.sleep(self.retry_delay)
                elif e.response.status_code == 404:  # Too Many Requests
                    print(f"RSI handle not found")
                    raise ValueError("RSI handle doesn't exit")
                else:
                    raise  # Re-raise the exception if it's not a rate limit issue

            except Exception as e:
                print(f"An error occurred: {e}")
                break  # Exit the loop on other errors

            time.sleep(1)  # Polite delay between requests

    def __init__(self, RSI_handle):
        """
        Fetch informations of an RSI_account.

        Args:
            RSI_handle (str): The RSI handle of the account.
        """
        current_file_folder_path = os.path.dirname(os.path.abspath(__file__))
        semaphore = FileSemaphore(current_file_folder_path+"/rsi_request.lock")
        
        self.max_retries = 5
        self.retry_delay = 3  # seconds
        
        self.RSI_handle = None
        self.Moniker = None
        self.ORGS = []
        self.email = None
        self.main_org = None
        self.Rank = None
        self.image_link = None
        self.citizen = None
        self.join_date = None
        self.bio = None
        
        
        
        self.link = f'{DEFAULT_RSI_URL}/citizens/{RSI_handle}'
        self.org_link = f'{self.link}/organizations'
        
        if semaphore.acquire():
            try:
                print("Semaphore acquired, accessing shared resource...")
                self.fetch_information(RSI_handle)
            finally:
                semaphore.release()
                print("Semaphore released.")
        else:
            print("Failed to acquire semaphore within timeout.")
        
        

    def corp_member(self):
        """
        Checks if the account is a member of the CORP organization.

        Returns:
            bool: True if the account is a member of the CORP organization, False otherwise.
        """
        if self.main_org == "CORP":
            return True
        elif 'CORP' in self.ORGS:
            return True
        else:
            return False
    '''
    def confirm_email(self, email):
        """
        Confirms if the given email matches the account's email.

        Args:
            email (str): The email to be confirmed.

        Returns:
            bool: True if the given email matches the account's email, False otherwise.
        """
        if self.email.lower() == email.lower():
            return True
        else:
            return False
    '''    
    def confirm_token(self, token):
        """
        Confirms if the given token is present in the account's bio.

        Args:
            token (str): The token to be confirmed.

        Returns:
            bool: True if the given token is present in the account's bio, False otherwise.
        """
        
        if self.bio and self.bio.find(token) != -1:
            return True
        else:
            return False

        
        
    
    def as_json(self):
        """
        Returns the account information as a JSON object.

        Returns:
            dict: The account information as a JSON object.
        """
        json = {
            'Link': self.link,
            'RSI_handle': self.RSI_handle, 
            'Moniker': self.Moniker,
            'citizen_code': self.citizen,
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

    def __repr__(self):
        return f"RSI_account(RSI_handle={self.RSI_handle}, Moniker={self.Moniker}, citizen_code={self.citizen}, Email={self.email}, Join_date={self.join_date}, Main_Org={self.main_org}, image={self.image_link})"

    def as_dict(self):
        """
        Returns the account information as a dictionary.

        Returns:
            dict: The account information as a dictionary.
        """
        account_dict = {
            'Link': self.link,
            'RSI_handle': self.RSI_handle, 
            'Moniker': self.Moniker,
            'citizen_code': self.citizen,
            'Join_date': self.join_date,
            'Main_Org': self.main_org,
            'Orgs': [org for org in self.ORGS],
            'image': self.image_link,
            'bio': self.bio
        }
        return account_dict


# testing code

import queue, threading

def fetch_account_data(q, handle):
    print(f"Fetching data for handle: {handle}")  # Debugging print
    try:
        account = RSI_account(RSI_handle=handle)
        account_data = account.as_dict()
        #account_data = account.confirm_token("blablabla")
        if account_data:  # Check if account_data is not empty
            q.put(account_data)
            print(f"Data fetched for {handle}: {account_data}")  # Debugging print
        else:
            print(f"No data returned for {handle}.")  # Debugging print
    except Exception as e:
        print(f"Error fetching data for {handle}: {e}")  # Error handling

def main():
    # Create a queue for thread-safe communication
    q = queue.Queue()

    # Define RSI handles for demonstration
    handles = ["Stevote"]*100 #, "Stevote", "OFG", "Vizi"

    # Create and start threads
    threads = []
    for handle in handles:
        t = threading.Thread(target=fetch_account_data, args=(q, handle))
        t.start()
        threads.append(t)

    # Wait for all threads to complete
    for t in threads:
        t.join()

    # Retrieve and print all account data from the queue
    while not q.empty():
        account_data = q.get()
        print(account_data)

if __name__ == "__main__":
    main()