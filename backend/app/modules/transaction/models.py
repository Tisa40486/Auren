from app.core.database import Base
from app.shared.enums import TransactionType
from sqlalchemy import Column, DateTime, ForeignKey, Integer
from sqlalchemy import Enum as SAEnum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func


class Transaction(Base):
    __tablename__ = "transactions"
    
    id = Column(Integer, primary_key=True)
    accountId = Column(Integer, ForeignKey("accounts.id"), nullable=False)
    amount = Column(Integer)
    transactionType = Column(SAEnum(TransactionType), nullable=False)
    createdAt = Column(DateTime(timezone=True), server_default=func.now())
    
    account = relationship("Account")