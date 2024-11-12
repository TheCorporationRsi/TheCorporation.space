from corp_system.bot.security_wraps import admin_only, CORP_only, manager_only

from corp_system.models import User
from corp_system import db

@admin_only
def test_admin(ctx):
    '''!test_admin'''
    ctx.send("Seem to work?")
    print("test_triggered!")


@CORP_only
def test_CORP(ctx):
    '''!test_CORP'''
    ctx.send("Seem to work?")
    print("test_triggered!")


@manager_only
def test_manager(ctx):
    '''!test_manager'''
    ctx.send("Seem to work?")
    print("test_triggered!")


def test(ctx):
    '''!test'''
    ctx.send("Seem to work?")
    print("test_triggered!")

def repeat(ctx):
    '''!repeat <string>'''
    ctx.send(str(ctx.get_argument(0, "string").value))
    print("test_triggered!")