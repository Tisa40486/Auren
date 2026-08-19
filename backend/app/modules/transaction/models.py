from app.core.database import Base
from app.shared.enums import TransactionType, CategoryType
from sqlalchemy import Column, DateTime, Float, ForeignKey, Integer, String
from sqlalchemy import Enum as SAEnum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func


class Transaction(Base):
    __tablename__ = "transactions"
    
    id = Column(Integer, primary_key=True)
    accountId = Column(Integer, ForeignKey("accounts.id"), nullable=False)
    amount = Column(Float)
    comment = Column(String, nullable=True)
    transactionType = Column(SAEnum(TransactionType), nullable=False)
    categoryId = Column(Integer, ForeignKey("transactionsCategories.id"), nullable=True)
    createdAt = Column(DateTime(timezone=True), server_default=func.now())
    
    account = relationship("Account")
    transactionCategory = relationship("TransactionCategory")
    
    
    
class TransactionCategory(Base):
    __tablename__ = "transactionsCategories"
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    type = Column(SAEnum(CategoryType))
    color = Column(String)
    icon = Column(String)
