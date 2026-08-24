from app.modules.finance.models import Account
from app.modules.log.services import create_log
from app.modules.transaction.models import Transaction, TransactionCategory
from app.modules.transaction.schemas import TransactionCategoryCreate, TransactionCreate
from app.shared.enums import ActionType, CategoryType, TransactionType
from fastapi import HTTPException
from sqlalchemy.orm import Session, joinedload


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
            comment = tran.comment,
            categoryId = tran.categoryId
        )
        db.add(db_tran)
        db.commit()
        db.refresh(db_tran)

        create_log(
            accountId=tran.accountId,
            actionType=ActionType.TRANSACTION_CREATED,
            details={"amount": tran.amount, "type": tran.transactionType.value, "comment": tran.comment},
        )

        return db_tran

    except HTTPException:
        db.rollback()
        create_log(
            accountId=tran.accountId,
            actionType=ActionType.TRANSACTION_FAILED,
            details={"amount": tran.amount, "type": tran.transactionType.value, "comment": tran.comment},
        )
        raise

def create_transaction_categories(db: Session, trancat: TransactionCategoryCreate) -> TransactionCategory:
    
    db_trancat = TransactionCategory(
        name = trancat.name,
        type = trancat.transactionType,
        color = trancat.color,
        icon = trancat.color
    )
    db.add(db_trancat)
    db.commit()
    db.refresh(db_trancat)
    return db_trancat

def get_all_transaction(db: Session):
    return db.query(Transaction).all()

def get_transaction_By_AccountId(db: Session, account_id: int):
    return db.query(Transaction).options(joinedload(Transaction.account)).filter(Transaction.accountId == account_id).all()

def get_all_transaction_categories(db: Session):
    return db.query(TransactionCategory).all()

def get_transaction_categories_by_id(db: Session, id : int):
    return db.query(TransactionCategory).filter(TransactionCategory.id == id).all()

def get_all_transaction_categories_Income(db: Session):
    return db.query(TransactionCategory).filter(TransactionCategory.type == CategoryType.INCOME)

def get_all_transaction_categories_Expense(db: Session):
    return db.query(TransactionCategory).filter(TransactionCategory.type == CategoryType.EXPENSE)

def get_all_transaction_categories_Both(db: Session):
    return db.query(TransactionCategory).filter(TransactionCategory.type == CategoryType.BOTH)