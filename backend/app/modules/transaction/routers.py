from fastapi import APIRouter, Depends, HTTPException
from app.core.database import SessionLocal
from app.modules.transaction.schemas import TransactionCreate, TransactionOut
from app.modules.transaction import services
from sqlalchemy.orm import Session
from app.core.database import get_db


transactionRouter = APIRouter(
    prefix="/transaction",
    tags=["transaction"]
)

db = SessionLocal()


@transactionRouter.get("/")
def get_transaction():
    return services.get_all_transaction(db)

@transactionRouter.post("/")
def create_transaction(tran: TransactionCreate, db: Session = Depends(get_db)):
        return services.create_transaction(db, tran)