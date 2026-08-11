import datetime as dt

from app.shared.enums import TransactionType
from pydantic import BaseModel, Field


class TransactionCreate(BaseModel):
    accountId: int
    amount: float = Field(gt=0)
    transactionType: TransactionType
    comment: str


class TransactionOut(BaseModel):
    id: int
    accountId: int
    amount: float
    transactionType: TransactionType
    createdAt: dt.datetime
    comment: str

    class Config:
        from_attributes = True