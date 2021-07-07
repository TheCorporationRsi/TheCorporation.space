from datetime import datetime, timedelta
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from corporation import db, login_manager, bcrypt, socketio
from flask_login import UserMixin
from flask import current_app, flash
from sqlalchemy import or_
from corporation.data.scraping import RSI_account


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# ========================================================================
# User Database
# ========================================================================


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    registered = db.Column(db.Boolean, nullable=False, default=False)
    # User info
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    RSI_moniker = db.Column(db.String(32), nullable=True)
    RSI_number = db.Column(db.Integer, nullable=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    image_file = db.Column(db.String(20), nullable=False,
                           default='default.jpg')

    # Linked account
    discord_username = db.Column(db.String(32), unique=True, nullable=True)
    discord_id = db.Column(db.String(32), unique=True, nullable=True)

    guilded_username = db.Column(db.String(32), unique=False, nullable=True)
    guilded_id = db.Column(db.String(32), unique=True, nullable=True)

    # Security level
    login_attempt = db.Column(db.Integer, unique=False,
                              nullable=True, default=0)
    security = db.Column(db.Integer, unique=False, nullable=True)
    email_confirmed = db.Column(db.Boolean, nullable=False, default=False)
    corp_confirmed = db.Column(db.Boolean, nullable=False, default=False)

    def test_password(self, password):
        test = bcrypt.check_password_hash(self.password, password)
        if self.login_attempt is None:
            self.login_attempt = 0
            db.session.commit()
        if test and self.login_attempt >= 3:
            self.login_attempt += 1
            flash('Too much attempt please try again later or ask moderator', 'danger')
            if self.login_attempt > 5:
                self.email_confirmed = False
                db.session.commit()
            return False
        elif test:
            return True
        else:
            self.login_attempt += 1
            db.session.commit()
            return False

    def get_reset_token(self, expires_sec=1800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    def get_confirmation_token(self, expires_sec=172800):
        s = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return s.dumps({'user_id': self.id}).decode('utf-8')

    @staticmethod
    def verify_reset_token(token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            user_id = s.loads(token)['user_id']
        except:
            return None
        return User.query.get(user_id)

    def roles(self):
        roles_list = Role.query.order_by(
            Role.department_id, Role.division_id, Role.title).all()
        roles = []
        for role in roles_list:
            if self.has_role(role):
                roles.append(role)
        return roles

    def has_role(self, role):
        link = Rolevsuser.query.filter_by(
            user_id=self.id, role_id=role.id).first()
        if link:
            return True
        return False

    def his_member(self, division):
        links = Rolevsuser.query.filter_by(user_id=self.id,).all()
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            if role.div_member and role.division_id == division.id:
                return True
        return False

    def his_member_dep(self, department):
        links = Rolevsuser.query.filter_by(user_id=self.id).all()
        for link in links:
            role = Role.query.filter_by(id=link.role_id).first()
            if role.div_member and role.department_id == department.id:
                return True
        return False

    def div_weight(self, division):
        role = Role.query.filter_by(
            division_id=division.id, div_member=True).first()
        link = Rolevsuser.query.filter_by(
            user_id=self.id, role_id=role.id).first()
        
        if not link:
            return 0
        
        return link.weight

    def div_influence(self, division):
        
        influence = Influence.query.filter_by(user_id = self.id, division = division.id).first()
        
        if not influence:
            return 0
        
        return influence.amount

    def dep_weight(self, department):
        weight = 0
        for division in department.divisions:
            weight += self.div_weight(division)
        return weight

    def add_role(self, role, origin = None):
        link = Rolevsuser.query.filter_by(
            user_id=self.id, role_id=role.id).first()
        if not link:
            link = Rolevsuser(
                user_id=self.id, RSI_handle=self.RSI_handle, role_id=role.id)
            db.session.add(link)
        db.session.commit()
        if not origin:
            self.update_discord_roles()

    def remove_role(self, role, origin = None):
        link = Rolevsuser.query.filter_by(
            user_id=self.id, role_id=role.id).first()
        if link:
            Rolevsuser.query.filter_by(
                user_id=self.id, role_id=role.id).delete()
        db.session.commit()
        if not origin:
            self.update_discord_roles()

    def is_manager(self, manager_type=None, division=-1, department=-1):
        if self.security == 5:
            return True
        links = Rolevsuser.query.filter_by(user_id=self.id).all()
        if division == -1 and department == -1:
            for link in links:
                role = Role.query.filter_by(id=link.role_id).first()
                if manager_type == None and (role.dep_head or role.dep_proxy or role.div_head or role.div_proxy):
                    return True
                elif(manager_type == "dep_head" and role.dep_head):
                    return True
                elif(manager_type == "div_head" and role.div_head):
                    return True
                elif(manager_type == "dep_proxy" and role.dep_proxy):
                    return True
                elif(manager_type == "div_proxy" and role.div_proxy):
                    return True

        elif division == 0 and department == 0:
            if self.security == 5:
                return True

        elif division > -1:
            division = Division.query.filter_by(id=division).first()
            for link in links:
                role = Role.query.filter_by(role_id=link.role_id).first()
                if ((role.dep_head or role.div_head) and role.division_id == division.id):
                    return True

        elif department > -1:
            for link in links:
                role = Role.query.filter_by(id=link.role_id).first()
                if (role.dep_head and role.department_id == department):
                    return True

        return False

    def highest_rank(self):

        if self.security == 5:
            return "admin"
        elif self.is_manager("dep_head"):
            for link in self.roles:
                if link.role.dep_head:
                    return link.role
        elif self.is_manager():
            for link in self.roles:
                if link.role.div_head:
                    return link.role
        else:
            return None

    def tribute(self):
        tribute = Tribute.query.filter_by(user_id=self.id).first()

        if not tribute:
            self.upgrade()

        tribute = Tribute.query.filter_by(user_id=self.id).first()

        return tribute

    def send_tribute(self, receiver, amount, message="none"):
        tribute = self.tribute()
        receiver_links = Rolevsuser.query.filter_by(user_id=receiver.id).all()
        print("start")
        count = 0
        for link in receiver_links:
            count += link.weight

        if count == 0:
            print("count = 0")
            test = 0
            for link in receiver_links:
                role = Role.query.filter_by(id=link.role_id).first()
                if role.div_member:
                    test += 1

            if test == 0:
                print("no division")
                transaction = Influence_transaction( user_from_handle = self.RSI_handle, user_to_handle = receiver.RSI_handle,
                    user_from=self.id, user_to=receiver.id, amount=amount, message=message)
                db.session.add(transaction)
                tribute.amount -= amount

                influence = Influence.query.filter_by(
                    user_id=receiver.id, department=0, division=0)
                if not influence:
                    influence = Influence(
                        user_id=receiver.id, RSI_handle=receiver.RSI_handle, department=0, division=0)
                    db.session.add(influence)
                influence.amount += amount

                influence2 = Influence.query.filter_by(
                    user_id=self.id, department=0, division=0)
                if not influence2:
                    influence2 = Influence(
                        user_id=self.id, RSI_handle=self.RSI_handle, department=0, division=0)
                    db.session.add(influence2)
                influence2.amount += amount

                db.session.commit()
                return 0
            else:
                print("division but 0")
                for link in receiver_links:
                    role = Role.query.filter_by(id=link.role_id).first()
                    if role.div_member:
                        link.weight = 99/test
        db.session.commit()
        if count > 100 or tribute.amount < amount:
            print("too much")
            print(str(count))
            print(str(tribute.amount))
            print("error in " + receiver.RSI_handle+" influence")
            for link in receiver_links:
                link.weight = 0
            db.session.commit()
            return -1
        else:
            print("start transfer")
            transfer_weight_json = {}
            transfer_weight_json[self.RSI_handle] = []
            transfer_weight_json[receiver.RSI_handle] = []
            common_weight = 0
            for link in receiver_links:
                role = Role.query.filter_by(id=link.role_id).first()
                if role.div_member and link.weight > 0:
                    department = Department.query.filter_by(
                        id=role.department_id).first()
                    division = Division.query.filter_by(
                        id=role.division_id).first()
                    if self.has_role(role) or self.his_member_dep(department):
                        common_weight += link.weight
                        transfer_weight_json[self.RSI_handle].append({
                            'division': division.id,
                            'weight': self.div_weight(division=division)
                        })
                        transfer_weight_json[receiver.RSI_handle].append({
                            'division': division.id,
                            'weight': link.weight
                        })

            if common_weight == 0:
                transaction = Influence_transaction(user_from_handle = self.RSI_handle, user_to_handle = receiver.RSI_handle,
                    user_from=self.id, user_to=receiver.id, amount=amount, message=message)
                db.session.add(transaction)
                tribute.amount -= amount

                influence = Influence.query.filter_by(
                    user_id=receiver.id, department=0, division=0)
                if not influence:
                    influence = Influence(
                        user_id=receiver.id, RSI_handle=receiver.RSI_handle, department=0, division=0)
                    db.session.add(influence)
                influence.amount += amount

                influence2 = Influence.query.filter_by(
                    user_id=self.id, department=0, division=0)
                if not influence2:
                    influence2 = Influence(
                        user_id=self.id, RSI_handle=self.RSI_handle, department=0, division=0)
                    db.session.add(influence2)
                influence2.amount += amount

                db.session.commit()
                return 0

            transaction = Influence_transaction(user_from_handle = self.RSI_handle, user_to_handle = receiver.RSI_handle,
                user_from=self.id, user_to=receiver.id, amount=amount, message=message, div_list=transfer_weight_json)
            db.session.add(transaction)
            tribute.amount -= amount
            for link in receiver_links:
                print("transfer")
                role = Role.query.filter_by(id=link.role_id).first()
                if role.div_member and link.weight > 0:
                    department = Department.query.filter_by(
                        id=role.department_id).first()
                    if self.has_role(role):
                        print("same division")
                        influence = Influence.query.filter_by(
                            user_id=receiver.id, department=role.department_id, division=role.division_id).first()
                        if not influence:
                            influence = Influence(user_id=receiver.id, RSI_handle=receiver.RSI_handle,
                                                  department=role.department_id, division=role.division_id)
                            db.session.add(influence)
                            db.session.commit()

                        influence2 = Influence.query.filter_by(
                            user_id=self.id, department=role.department_id, division=role.division_id).first()
                        if not influence2:
                            influence2 = Influence(
                                user_id=self.id, RSI_handle=self.RSI_handle, department=role.department_id, division=role.division_id)
                            db.session.add(influence2)
                            db.session.commit()

                    elif self.his_member_dep(department):
                        print("same department")
                        influence = Influence.query.filter_by(
                            user_id=receiver.id, department=role.department_id, division=0).first()
                        if influence is None:
                            influence = Influence( user_id=receiver.id, RSI_handle=receiver.RSI_handle, department=role.department_id, division=0)
                            db.session.add(influence)
                            db.session.commit()

                        influence2 = Influence.query.filter_by( user_id=self.id, department=role.department_id, division=0).first()
                        if influence2 is None:
                            influence2 = Influence(
                                user_id=self.id, RSI_handle=self.RSI_handle, department=role.department_id, division=0)
                            db.session.add(influence2)
                            db.session.commit()
                            
                    influence.amount += amount*(link.weight/common_weight)
                    influence2.amount += amount*(link.weight/common_weight)
                    print("transfer done")
        print("finalize")
        tribute = self.tribute()
        receiver_tribute = receiver.tribute()

        tribute.lifetime_influence += amount
        receiver_tribute.lifetime_influence += amount
        db.session.commit()
        print("done")
        return 0

    def inf_transfer_history(self, type='sent'):
        if type == 'sent':
            transactions = Influence_transaction.query.filter_by(
                user_from=self.id).all()
            return transactions
        elif type == 'received':
            transactions = Influence_transaction.query.filter_by(
                user_to=self.id).all()
            return transactions

    def upgrade(self):
        tribute = Tribute.query.filter_by(user_id=self.id).first()

        if not tribute:
            tribute = Tribute(user_id=self.id, RSI_handle=self.RSI_handle)
            db.session.add(tribute)
            db.session.commit()

    def update_info(self):
        RSI_info = RSI_account(RSI_handle=self.RSI_handle)
        corp_role = Role.query.filter_by(title='Corporateer').first()

        if RSI_info.corp_member():
            self.corp_confirmed = True
            self.add_role(corp_role)

        tribute = Tribute.query.filter_by(user_id=self.id).first()
        if not tribute:
            tribute = Tribute(user_id=self.id, RSI_handle=self.RSI_handle)
            db.session.add(tribute)

        influences = Influence_transaction.query.filter(or_(
            Influence_transaction.user_to == self.id, Influence_transaction.user_from == self.id,)).all()
        count = 0
        for influence in influences:
            count += influence.amount
        self.tribute().lifetime_influence = count

        self.RSI_moniker = RSI_info.Moniker
        self.image_file = RSI_info.image_link
        db.session.commit()

        self.update_discord_roles()
        self.tribute()

    def influence_count(self, type=None, department=None, division=None):

        if type == "general":
            influences = Influence.query.filter_by(
                user_id=self.id, department=0, division=0).all()
        elif department is None and division is None:
            influences = Influence.query.filter_by(user_id=self.id).all()
        elif division is None:
            influences = Influence.query.filter_by(
                user_id=self.id, department=department).all()
        else:
            influences = Influence.query.filter_by(
                user_id=self.id, department=department, division=division).all()
        count = 0
        for influence in influences:
            count += influence.amount

        return count

    def lifetime_influence_count(self, type=None, department=None, division=None):

        return self.tribute().lifetime_influence

    def influence_rank(self):
        ranks = Influence_rank.query.order_by(
            Influence_rank.required_influence.desc()).all()
        lifetime_influence = self.lifetime_influence_count()

        for rank in ranks:
            if lifetime_influence >= rank.required_influence:
                return rank

    def receive_weekly_tribute(self):
        rank = self.influence_rank()
        tribute = self.tribute()

        tribute.amount += rank.weekly_amount

        if tribute.amount > 1.5*rank.weekly_amount:
            tribute.amount = 1.5*rank.weekly_amount

        db.session.commit()

    def update_discord_roles(self):
        all_roles = Role.query.all()
        if self.discord_id is not None:
            socketio.emit('change_nickname', {'member_id': self.discord_id, 'nickname': self.RSI_handle}, namespace='/discord_bot')
            for role in all_roles:
                if not role.discord_id == 0 and not role.discord_id == None:
                    if self.has_role(role):
                        socketio.emit('add_role', {
                                      'user': self.discord_id, 'role_id': role.discord_id}, namespace='/discord_bot')
                    else:
                        socketio.emit('delete_role', {
                                      'user': self.discord_id, 'role_id': role.discord_id}, namespace='/discord_bot')
    def upload_discord_roles(self):
        if self.discord_id is not None:
            socketio.emit('upload_roles', {'user': self.discord_id}, namespace='/discord_bot')

    def as_dict(self):
        return {
            'name': self.RSI_handle,
            'moniker': self.RSI_moniker
        }

    def __repr__(self):
        return f"User('{self.RSI_handle}', '{self.email}', '{self.discord_username}', '{self.image_file}')"

# ========================================================================
# User Database
# ========================================================================
# Role database
# ========================================================================


class Rolevsuser(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    user_id = db.Column(db.Integer, nullable=False)
    RSI_handle = db.Column(db.String(32), nullable=False)
    weight = db.Column(db.Integer, nullable=True, default=0)
    date_added = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)


class Role(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    color = db.Column(db.String(32), unique=False, nullable=True)
    rule = db.Column(db.Integer, nullable=True, default=0)

    division_id = db.Column(
        db.Integer, db.ForeignKey('division.id'), nullable=True)
    dep_head = db.Column(db.Boolean, nullable=False, default=False)
    dep_proxy = db.Column(db.Boolean, nullable=False, default=False)
    department_id = db.Column(
        db.Integer, db.ForeignKey('department.id'), nullable=True)
    div_head = db.Column(db.Boolean, nullable=False, default=False)
    div_proxy = db.Column(db.Boolean, nullable=False, default=False)
    div_member = db.Column(db.Boolean, nullable=False, default=False)

    discord_id = db.Column(db.Integer, unique=True, nullable=True)
    guilded_id = db.Column(db.Integer, unique=True, nullable=True)

    def member_count(self):
        return Rolevsuser.query.filter_by(role_id=self.id).count()

    def role_color(self):
        if self.department_id:
            department = Department.query.filter_by(
                id=self.department_id).first()
            return department.color
        elif self.color:
            return self.color
        else:
            return "white"

    def __repr__(self):
        return f"Role('{self.title}', '{self.date_added}')"


class Division(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    roles = db.relationship('Role', backref='division', lazy='dynamic')
    department_id = db.Column(db.Integer, db.ForeignKey(
        'department.id'), nullable=False)
    logo = db.Column(db.String(20), nullable=False, default='default.png')
    moto = db.Column(db.String(200), nullable=False, default='Empty')

    def member_count(self):
        users = self.members()
        return len(users)

    def members(self):
        users = []
        for role in self.roles:
            if role.div_member:
                members = Rolevsuser.query.filter_by(role_id=role.id).all()
                for member in members:
                    user = User.query.filter_by(
                        RSI_handle=member.RSI_handle).first()
                    if user not in users:
                        users.append(user)
        return users

    def has_member(self, member):
        for role in self.roles:
            if member.has_role(role):
                return True
        return False

    def color(self):
        department = Department.query.filter_by(id=self.department_id).first()
        return department.color

    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'color': self.color()
        }

    def __repr__(self):
        return f"Division('{self.title}', '{self.date_added}')"


class Department(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    created_by = db.Column(db.String(32), nullable=False)
    color = db.Column(db.String(32), unique=False,
                      nullable=False, default='red')
    roles = db.relationship('Role', backref='department', lazy='dynamic')
    divisions = db.relationship(
        'Division', backref='department', lazy='dynamic')

    image_file_1 = db.Column(
        db.String(20), nullable=False, default='default.jpg')
    image_file_2 = db.Column(
        db.String(20), nullable=False, default='default.jpg')
    image_file_3 = db.Column(
        db.String(20), nullable=False, default='default.jpg')
    image_file_4 = db.Column(
        db.String(20), nullable=False, default='default.jpg')

    image_div_presentation = db.Column(
        db.String(20), nullable=False, default='default.jpg')

    def member_count(self):
        users = self.members()
        return len(users)

    def members(self):
        users = []
        roles = Role.query.filter_by(department_id = self.id).all()
        for role in roles:
            if role.div_member:
                members = Rolevsuser.query.filter_by(role_id=role.id).all()
                for member in members:
                    user = User.query.filter_by(id = member.user_id).first()
                    if user not in users:
                        users.append(user)
        return users

    def webpage_details(self):
        templates = Webpage_template.query.filter_by(
            division_id=None, department_id=self.id)
        return templates

    def as_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'color': self.color
        }

    def __repr__(self):
        return f"Department('{self.title}', '{self.date_added}')"


class Webpage_template(db.Model):
    __bind_key__ = 'role_db'
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.Integer, nullable=True, default=0)
    title = db.Column(db.String(100), nullable=False, default='empty')
    title2 = db.Column(db.String(100), nullable=False, default='empty')
    text = db.Column(db.String(200), nullable=False, default='Empty')
    background_image = db.Column(
        db.String(20), nullable=False, default='default.jpg')

    division_id = db.Column(db.Integer, db.ForeignKey(
        'division.id'), nullable=False, default=0)
    department_id = db.Column(db.Integer, db.ForeignKey(
        'department.id'), nullable=False, default=0)

    def __repr__(self):
        return f"Department('{self.title}', '{self.background_image}')"

# ========================================================================
# Role Database
# ========================================================================
# Social database
# ========================================================================


class Post(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False,
                            default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    chat = db.relationship('Message', backref='container', lazy=True)
    RSI_handle = db.Column(db.String(32), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"


class Message(db.Model):
    __bind_key__ = 'social_db'
    id = db.Column(db.Integer, primary_key=True)
    sender = db.Column(db.String(32), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False,
                            default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    link = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)

    def __repr__(self):
        return f"Message('{self.title}', '{self.date_posted}')"

# ========================================================================
# Social Database
# ========================================================================
# Influence database
# ========================================================================


class Tribute(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    last_payment = db.Column(
        db.DateTime, nullable=False, default=datetime.utcnow)
    user_id = db.Column(db.Integer, nullable=False)
    RSI_handle = db.Column(db.String(32), unique=True, nullable=False)
    amount = db.Column(db.Integer, nullable=False, default=0)
    lifetime_influence = db.Column(db.Integer, nullable=False, default=0)

    def __repr__(self):
        return f"Account('{self.RSI_handle}', '{self.last_payment}')"


class Influence_rank(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(32), unique=True, nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    required_influence = db.Column(
        db.Integer, unique=True, nullable=False, default=0)
    created_by = db.Column(db.String(32), nullable=False)
    weekly_amount = db.Column(db.Integer, unique=True,
                              nullable=False, default=50)

    def member_count(self):
        ...
        # return Influence_account.query.filter_by(rank=self.id).count()

    def __repr__(self):
        return f"Rank('{self.title}', '{self.date_added}')"


class Influence(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    RSI_handle = db.Column(db.String(32), unique=False, nullable=False)
    amount = db.Column(db.Integer, nullable=False, default=0)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)

    department = db.Column(db.Integer, nullable=True, default=0)
    division = db.Column(db.Integer, nullable=True, default=0)

    def __repr__(self):
        return f"Influence_history('{self.title}', '{self.date_added}')"


class Influence_transaction(db.Model):
    __bind_key__ = 'influence_db'
    id = db.Column(db.Integer, primary_key=True)
    user_from = db.Column(db.Integer, nullable=False)
    user_from_handle = db.Column(db.String(32), nullable=False)
    user_to = db.Column(db.Integer, nullable=False)
    user_to_handle = db.Column(db.String(32), nullable=False)
    method = db.Column(db.String(32), nullable=False, default='unkown')
    amount = db.Column(db.Integer, nullable=False, default=0)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    message = db.Column(db.Text, nullable=True)
    div_list = db.Column(db.JSON, nullable=True)

    def __repr__(self):
        return f"Transaction('{self.title}', '{self.date_added}')"


# ========================================================================
# Influence Database
# ========================================================================
# Logs database
# ========================================================================
class Logs(db.Model):
    __bind_key__ = 'logs_db'
    id = db.Column(db.Integer, primary_key=True)
    RSI_handle = db.Column(db.String(100), nullable=False)
    date_added = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    action_type = db.Column(db.String(100), nullable=False)
    original = db.Column(db.String(100), nullable=False)
    Result = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f"Logs('{self.title}', '{self.user_id}', '{self.date_added}')"

