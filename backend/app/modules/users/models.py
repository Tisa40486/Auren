from app.core.database import Base
from firebase_admin import db
from sqlalchemy import Boolean, Column, Integer, String, event


class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String, unique=True)
    password = Column(String)
    updated = Column(Boolean) 
    
@event.listens_for(User, 'after_update')
def receive_after_update(mapper, connection, target):
    ref = db.reference(f'users/{target.id}')
    ref.update({
        'status': target.status
    })