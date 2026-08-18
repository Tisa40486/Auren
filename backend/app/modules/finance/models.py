from app.core.database import Base
from sqlalchemy import Boolean, Column, Float, ForeignKey, Integer, String
from sqlalchemy.orm import relationship


class Account(Base):
    __tablename__ = "accounts"
    
    id = Column(Integer, primary_key=True)
    userId = Column(Integer, ForeignKey("users.id"))
    name = Column(String)
    amount = Column(Float)
    pinCode = Column(String)
    is_active = Column(Boolean, default=True, nullable=False)
    user = relationship("User")