from project import db, bcrypt
from flask import current_app, flash
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer

class security_methods:

    def test_password(self, password):
            test = bcrypt.check_password_hash(self._password, password)

            if self.login_attempt is None:
                self.login_attempt = 0   

            if self.login_attempt >= 3:
                self.login_attempt += 1
                if self.login_attempt > 4:
                    flash('Too much attempt please try again later or ask moderator', 'danger')
                if self.login_attempt > 5:
                    self.email_confirmed = False
                    db.session.commit()
                return False
            elif test:
                self.login_attempt = 0
                return True
            else:
                self.login_attempt += 1
                db.session.commit()
                return False

    def get_security_token(self, expires_sec=1800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    @classmethod
    def verify_security_token(ctx, token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            user_id = s.loads(token)['user_id']
        except:
            return None
        return ctx.query.get(user_id)