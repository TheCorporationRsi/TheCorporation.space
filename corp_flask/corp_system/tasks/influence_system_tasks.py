
from corp_system import scheduler, db

from corp_system.models import Influence
from corp_system.controllers.influence_system_manager import InfluenceSystemManager

@scheduler.task('cron', id='downgrade_influence', day='*')
def downgrade_influence():
   with scheduler.app.app_context():
    
      InfluenceSystemManager.update_influences()

@scheduler.task('cron', id='update_inf_account', day='*')
def update_inf_account():
   with scheduler.app.app_context():
    
      InfluenceSystemManager.update_accounts()

@scheduler.task('cron', id='merge_old_influence', week='*')
def merge_old_influence():
   with scheduler.app.app_context():
    
      InfluenceSystemManager.update_accounts()
