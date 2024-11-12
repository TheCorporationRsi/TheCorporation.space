from datetime import datetime

from corp_system import db

from corp_system.models import Base


class Funding(Base):
    __tablename__ = 'funding'

    citizens = db.Column(db.BigInteger, nullable=False)
    fund = db.Column(db.BigInteger, nullable=False)
    date = db.Column(db.Date, nullable=False, default=datetime.now())

    def as_dict(self):
        return {
            'citizens': self.citizens,
            'fund': self.fund,
            'date': self.date.isoformat(),
        }

    def __repr__(self):
        return f"Funding('{self.date}', '{self.fund}', '{self.citizens}')"