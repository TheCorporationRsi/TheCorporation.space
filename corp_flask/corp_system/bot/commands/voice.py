from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only

@CORP_only
def list_member(ctx):
    '''Not implemented yet'''
    channel = ctx.arguments[1]
    for user in channel.members():
        member = ctx.id_to_user(user['id'])
        if member == -1:
            ctx.send( ctx.user_mention(user_id=user['id']) + " not linked to the website.")
        else:
            ctx.send( user['username'] +" : "+ member.RSI_handle )

@CORP_only
def list_link(ctx):
    '''Not implemented yet'''
    channel = ctx.arguments[1]
    for user in channel.members():
        member = ctx.id_to_user(user['id'])
        if member == -1:
            ctx.send( ctx.user_mention(user_id=user['id']) + " not linked to the website.")
        else:
            ctx.send( user['username'] +" : <https://robertsspaceindustries.com/citizens/"+ member.RSI_handle +">" )