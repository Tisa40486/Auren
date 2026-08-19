import datetime as dt

from app.shared.enums import TransactionType, CategoryType
from pydantic import BaseModel, Field


class TransactionCreate(BaseModel):
    accountId: int
    amount: float = Field(gt=0)
    transactionType: TransactionType
    comment: str
    categoryId: int

class TransactionOut(BaseModel):
    id: int
    accountId: int
    amount: float
    transactionType: TransactionType
    createdAt: dt.datetime
    comment: str
    categoryId: int

    class Config:
        from_attributes = True
        
        
class TransactionCategoryCreate(BaseModel):
    name: str
    type: CategoryType
    color: str
    icon: str
    
class TransactionCategoryOut(BaseModel):
    id: int
    name: str
    type: CategoryType
    color: str
    icon: str
