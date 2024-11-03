import project.api.bots as bots
import project.api.bots.handlers.discord.controller as discord_controller

controllers = [discord_controller]


def add_role(user, role):
    for controller in controllers:
        controller.add_role(user, role)

def remove_role(user, role):
    for controller in controllers:
        controller.remove_role(user, role)

def sync_role():
    for controller in controllers:
        controller.sync_role()

def change_nickname(user, nickname):
    for controller in controllers:
        controller.change_nickname(user, nickname)

def send_dm(message, user):
    for controller in controllers:
        controller.send_dm(message, user)

def send_tribute(controller, sender_id, receiver_id, message_id, amount):
    
    sender = controller.id_to_user(sender_id)
    if not sender:
        controller.send_dm(message="You are not link to the website", user_id = receiver_id)
        return
    
    receiver = controller.id_to_user(sender_id)
    if not receiver:
        controller.send_dm(message="This member is not linked to the website", user_id = sender_id)
        controller.send_dm(message="Somebody tried to send you influence, but you are not linked to the website", user_id = receiver_id)
        return
    
    sender.send_tribute(receiver = receiver, amount = amount, message="discord_msg: "+ message_id , method="emote")
    controller.send_dm(message= "Transaction:"+ amount +" tribute sent to"+ receiver.RSI_handle , user_id = sender_id)

def start():
    status = {}
    for controller in controllers:
        try:
            controller.start()
            status[controller.__name__] = 'Running'
        except Exception as e:
            status[controller.__name__] = f'Failed to start: {e}'
    return status