import project.api.bots.commands as commands

trigger = "$"
    
def call(ctx):
    #ctx.send(ctx.arguments[0])
    #ctx.send(ctx.user)
    try:
        command = getattr(commands, ctx.arguments[0])
    except AttributeError:
        ctx.send('Command: "' + ctx.arguments[0] + '" not found')
    else: 
        command(ctx=ctx)