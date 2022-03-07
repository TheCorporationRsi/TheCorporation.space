from ..security_wraps import admin_only, manager_only, CORP_only, confirmed_RSI_only


@admin_only
def test(ctx, args):
    ctx.send("Seem to work?")
    