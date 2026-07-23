from pydantic import BaseModel, Field
from typing import Optional
import datetime as dt
from app.shared.Enum import TransactionType


class TransactionCreate(BaseModel):
    accountId: int
    amount: int = Field(gt=0)
    transactionType: TransactionType


class TransactionOut(BaseModel):
    id: int
    accountId: int
    amount: int
    transactionType: TransactionType
    createdAt: dt.datetime

    class Config:
        from_attributes = True