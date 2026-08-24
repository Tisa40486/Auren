from app.core.database import SessionLocal, get_db
from app.modules.transaction import services
from app.modules.transaction.schemas import (
    TransactionCategoryCreate,
    TransactionCategoryOut,
    TransactionCreate,
    TransactionOut,
)
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

transactionRouter = APIRouter(
    prefix="/transaction",
    tags=["transaction"]
)

db = SessionLocal()


@transactionRouter.get("/",response_model=list[TransactionOut])
def get_transaction():
    return services.get_all_transaction(db)

@transactionRouter.get("/categories/{categoryTransaction_id}",response_model=list[TransactionCategoryOut])
def get_transaction(categoryTransaction_id : int):
    return services.get_transaction_categories_by_id(db, categoryTransaction_id)

@transactionRouter.get("/categories",response_model=list[TransactionCategoryOut])
def get_transaction():
    return services.get_all_transaction_categories(db)

@transactionRouter.get("/categories/Income",response_model=list[TransactionCategoryOut])
def get_transaction():
    return services.get_all_transaction_categories_Income(db)

@transactionRouter.get("/categories/Expense",response_model=list[TransactionCategoryOut])
def get_transaction():
    return services.get_all_transaction_categories_Expense(db)

@transactionRouter.get("/categories/Both",response_model=list[TransactionCategoryOut])
def get_transaction():
    return services.get_all_transaction_categories_Both(db)

@transactionRouter.get("/{account_id}",response_model=list[TransactionOut])
def get_transaction_by_accountId(account_id : int):
    return services.get_transaction_By_AccountId(db, account_id)

@transactionRouter.post("/")
def create_transaction(tran: TransactionCreate, db: Session = Depends(get_db)):
        return services.create_transaction(db, tran)
    
@transactionRouter.post("/category")
def create_transaction(tran: TransactionCategoryCreate, db: Session = Depends(get_db)):
        return services.create_transaction_categories(db, tran)