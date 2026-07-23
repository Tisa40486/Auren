from app.core.database import Base
from sqlalchemy import Column, Integer, String, Boolean, Enum as SAEnum, DateTime, ForeignKey
from app.shared.Enum import TransactionType
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

class Transaction(Base):
    __tablename__ = "transaction"
    
    id = Column(Integer, primary_key=True)
    accountId = Column(Integer, ForeignKey("account.id"), nullable=False)
    amount = Column(Integer)
    transactionType = Column(SAEnum(TransactionType), nullable=False)
    createdAt = Column(DateTime(timezone=True), server_default=func.now())
    
    account = relationship("Account")