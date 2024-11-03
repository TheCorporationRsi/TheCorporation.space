import project.api.bots.security_wraps as security_wraps

@security_wraps.CORP_only
def list_member(ctx):
    channel = ctx.arguments[1]
    for user in channel.members():
        member = ctx.id_to_user(user['id'])
        if member == -1:
            ctx.send( ctx.user_mention(user_id=user['id']) + " not linked to the website.")
        else:
            ctx.send( user['username'] +" : "+ member.RSI_handle )

@security_wraps.CORP_only
def list_link(ctx):
    channel = ctx.arguments[1]
    for user in channel.members():
        member = ctx.id_to_user(user['id'])
        if member == -1:
            ctx.send( ctx.user_mention(user_id=user['id']) + " not linked to the website.")
        else:
            ctx.send( user['username'] +" : <https://robertsspaceindustries.com/citizens/"+ member.RSI_handle +">" )