from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only


@admin_only
def send_msg_to_channel(ctx):
    '''Not setup yet'''
    channel = ctx.arguments[1]
    string = ctx.arguments[2]
    for argument in ctx.arguments[3:]:
            string += " " + argument
    channel.send(string)
    ctx.send("Sent!")