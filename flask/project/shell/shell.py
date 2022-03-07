from flask_login import current_user, login_required

from . import commands

class shell():
    
    def error(self, ctx, args):
        ctx.send("Error!")
    
    def call(self, ctx, command, args):
        if ctx.user == -1:
            ctx.send("You are not linked to CORP website")
            return
        function = getattr(commands, command, self.error)
        function(ctx=ctx, args=args)