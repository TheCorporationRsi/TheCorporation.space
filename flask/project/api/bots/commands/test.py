import project.api.bots.security_wraps as security_wraps


@security_wraps.admin_only
def test_admin(ctx):
    ctx.send("Seem to work?")
    print("test_triggered!")


@security_wraps.CORP_only
def test_CORP(ctx):
    ctx.send("Seem to work?")
    print("test_triggered!")


@security_wraps.manager_only
def test_manager(ctx):
    ctx.send("Seem to work?")
    print("test_triggered!")


def test(ctx):
    ctx.send("Seem to work?")
    print("test_triggered!")


def test_user(ctx):
    user = ctx.arguments[1]
    ctx.send("Received: " + user.RSI_handle)
    print("test_triggered!")