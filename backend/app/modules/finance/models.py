from app.core.database import Base
from sqlalchemy import Column, ForeignKey, Integer, String, Boolean
from sqlalchemy.orm import relationship


class Account(Base):
    __tablename__ = "accounts"
    
    id = Column(Integer, primary_key=True)
    userId = Column(Integer, ForeignKey("users.id"))
    name = Column(String)
    amount = Column(Integer)
    pinCode = Column(String)
    is_active = Column(Boolean, default=True, nullable=False)
    user = relationship("User")