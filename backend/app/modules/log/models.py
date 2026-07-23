from app.core.database import Base
from sqlalchemy import Column, Integer, DateTime, JSON, Enum as SAEnum, ForeignKey, String
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.shared.Enum import ActionType

class Log(Base):
    __tablename__ = "log"

    id = Column(Integer, primary_key=True)
    accountId = Column(Integer, ForeignKey("account.id"), nullable=False)
    actionType = Column(SAEnum(ActionType), nullable=False)
    details = Column(JSON, nullable=True)
    ipAddress = Column(String, nullable=True)
    createdAt = Column(DateTime(timezone=True), server_default=func.now())

    account = relationship("Account")