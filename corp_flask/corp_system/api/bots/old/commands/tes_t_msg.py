import project.api.bots.security_wraps as security_wraps


@security_wraps.admin_only
def send_msg_to_channel(ctx):
    channel = ctx.arguments[1]
    string = ctx.arguments[2]
    for argument in ctx.arguments[3:]:
            string += " " + argument
    channel.send(string)
    ctx.send("Sent!")