from corp_system import db
from sqlalchemy.orm import backref
from .. import Base


class Inf_Tribute(Base):
    __tablename__ = "inf_tribute"
    
    # Sender
    sender_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=False)
    sender = db.relationship("Inf_Account", backref="sent_tributes", foreign_keys=[sender_id])
    sender_influence = db.Column(db.JSON, nullable=False)
    
    # Receiver
    receiver_id = db.Column(db.String(36), db.ForeignKey('inf_account.id'), nullable=False)
    receiver = db.relationship("Inf_Account", backref="received_tributes", foreign_keys=[receiver_id])
    receiver_influence = db.Column(db.JSON, nullable=False)

    # Method used to transfer
    method = db.Column(db.String(32), nullable=False, default='unknown')
    
    # Amount transferred
    amount = db.Column(db.Integer, nullable=False, default=0)
    
    # Personalized message
    message = db.Column(db.Text, nullable=False, default='')
    

    def delete(self):
        for influence in self.influences:
            influence.delete()
        
        db.session.delete(self)
        db.session.commit()
        
    def as_dict(self):
        return {
            'id': self.id,
            'sender': self.sender.as_dict(),
            'receiver': self.receiver.as_dict(),
            'method': self.method,
            'amount': self.amount,
            'message': self.message,
            'influences': [influence.as_dict() for influence in self.influences]
        }
