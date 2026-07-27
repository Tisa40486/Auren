from app.core.database import Base
from app.shared.enums import ActionType
from sqlalchemy import JSON, Column, DateTime, ForeignKey, Integer, String
from sqlalchemy import Enum as SAEnum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func


class Log(Base):
    __tablename__ = "log"

    id = Column(Integer, primary_key=True)
    accountId = Column(Integer, ForeignKey("account.id"), nullable=False)
    actionType = Column(SAEnum(ActionType), nullable=False)
    details = Column(JSON, nullable=True)
    ipAddress = Column(String, nullable=True)
    createdAt = Column(DateTime(timezone=True), server_default=func.now())

    account = relationship("Account")