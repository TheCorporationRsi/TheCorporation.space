from locust import HttpUser, TaskSet, task, between
import random
import string

class LoggedInUserBehavior(TaskSet):
    registered = False

    def on_start(self):
        '''
        if not LoggedInUserBehavior.registered:
            self.register()
            LoggedInUserBehavior.registered = True'''
        self.login()

    ''' def register(self):
        self.client.post("/api/v0/register", json={
            "username": "Cyber-Dreamer",
            "password": "123CorpIsTheBest!",
            "confirmed_password": "123CorpIsTheBest!"
        })
    '''
    def login(self):
        response = self.client.post("/api/v0/login", json={
            "username": "Cyber-Dreamer",
            "password": "123CorpIsTheBest!"
        })
        self.token = response.cookies.get("corp_access_pass")
        
    @task
    def test_rsi_token(self):
        self.client.get("/api/v0/test_RSI_token", headers={"Authorization": f"Bearer {self.token}"})

    @task
    def ranks(self):
        self.client.get("/api/v0/influence_system/ranks", headers={"Authorization": f"Bearer {self.token}"})
    
    @task
    def departments(self):
        self.client.get("/api/v0/structure/departments", headers={"Authorization": f"Bearer {self.token}"})
        
    @task
    def divisions(self):
        self.client.get("/api/v0/structure/divisions", headers={"Authorization": f"Bearer {self.token}"})

class NotLoggedInUserBehavior(TaskSet):
    @task
    def ranks(self):
        self.client.get("/api/v0/influence_system/ranks")
    '''
    @task 
    def register(self):
        self.client.post("/api/v0/register", json={
            "username": "Cyber-Dreamer69",
            "password": "123CorpIsTheBest!",
            "confirmed_password": "123CorpIsTheBest!"
        })
    '''
    @task
    def departments(self):
        self.client.get("/api/v0/structure/departments")
        
    @task
    def divisions(self):
        self.client.get("/api/v0/structure/divisions")

class LoggedInUser(HttpUser):
    tasks = [LoggedInUserBehavior]
    wait_time = between(1, 5)

class NotLoggedInUser(HttpUser):
    tasks = [NotLoggedInUserBehavior]
    wait_time = between(1, 5)