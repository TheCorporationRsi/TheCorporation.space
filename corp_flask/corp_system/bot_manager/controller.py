from flask_socketio import Namespace, emit

from corp_system import limiter

class MyCustomNamespace(Namespace):
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        # get argument api_key from kwargs
        self.api_key = kwargs.get('api_key')
        
        # get bot name from kwargs
        self.bot_name = kwargs.get('bot_name')
    
    @limiter.limit("1 per minute")
    def on_connect(self, data):
        # ensure that the client that connect to this namespace has the correct api_key
        if data.get('api_key') != self.api_key:
            return False

    def on_disconnect(self):
        print(f'{self.bot_name} disconnected')

    