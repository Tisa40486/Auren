from app.core.database import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship


class Account(Base):
    __tablename__ = "account"
    
    id = Column(Integer, primary_key=True)
    userId = Column(Integer, ForeignKey("user.id"))
    name = Column(String)
    amount = Column(Integer)
    pinCode = Column(String)
    
    user = relationship("User")