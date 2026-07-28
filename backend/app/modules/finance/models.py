from app.core.database import Base
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Account(Base):
    __tablename__ = "accounts"
    
    id = Column(Integer, primary_key=True)
    userId = Column(Integer, ForeignKey("users.id"))
    name = Column(String)
    amount = Column(Integer)
    pinCode = Column(String)
    
    user = relationship("User")