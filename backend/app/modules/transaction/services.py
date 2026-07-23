from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.modules.transaction.models import Transaction
from app.modules.transaction.schemas import TransactionCreate
from app.modules.finance.models import Account
from app.shared.Enum import TransactionType, ActionType
from app.modules.log.services import create_log

def create_transaction(db: Session, tran: TransactionCreate) -> Transaction:
    account = db.query(Account).filter(Account.id == tran.accountId).first()
    if not account:
        raise HTTPException(status_code=404, detail="Account not found")

    try:
        if tran.transactionType == TransactionType.DEPOSIT:
            account.amount += tran.amount
        elif tran.transactionType == TransactionType.WITHDRAWAL:
            account.amount -= tran.amount

        db_tran = Transaction(
            accountId=tran.accountId,
            amount=tran.amount,
            transactionType=tran.transactionType,
        )
        db.add(db_tran)
        db.commit()
        db.refresh(db_tran)

        create_log(
            accountId=tran.accountId,
            actionType=ActionType.TRANSACTION_CREATED,
            details={"amount": tran.amount, "type": tran.transactionType.value},
        )

        return db_tran

    except HTTPException:
        db.rollback()
        create_log(
            accountId=tran.accountId,
            actionType=ActionType.TRANSACTION_FAILED,
            details={"amount": tran.amount, "type": tran.transactionType.value},
        )
        raise


def get_all_transaction(db: Session):
    return db.query(Transaction).all()