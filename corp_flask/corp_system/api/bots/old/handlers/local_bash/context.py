from project.models import User


class bash_ctx():
    
    type = "bash"
    
    def __init__(self, user, server, channel):
        user_id = user
        server_id = server
        channel_id = channel
        
    @property
    def user(self):
        user = User.query.filter_by(discord_id = self.user_id).first()
        return user if user else -1
    
    def send(self, message):
        pass


def init_bash():
    pass
    