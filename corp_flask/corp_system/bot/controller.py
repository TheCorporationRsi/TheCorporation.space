from .bots.discord.controller import discord_controller
from corp_system.models import Role, User

controllers = [discord_controller]


class Bot_controller():
    
    def __init__(self):
        pass
    
    def add_role(user: User, role: Role):
        for controller in controllers:
            controller.add_role(user, role)
    
    def remove_role(user: User, role: Role):
        for controller in controllers:
            controller.remove_role(user, role)
                                   
    def sync_role(user: User):
        for controller in controllers:
            controller.sync_role(user)
                
    def update_nickname(user: User):
        for controller in controllers:
            controller.update_nickname(user)
    
    def send_dm(user: User, message):
        for controller in controllers:
            controller.send_dm(user, message)