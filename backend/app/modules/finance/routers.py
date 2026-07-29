from app.core.database import get_db
from app.core.security import get_current_user
from app.modules.finance import services
from app.modules.finance.schemas import AccountCreate, AccountOut
from app.modules.users.models import User
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

financeRouter = APIRouter(
    prefix="/finance",
    tags=["finance"]
)

@financeRouter.get("/")
def get_accounts(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return services.get_all_accounts(db)

@financeRouter.post("/")
def create_account(account: AccountCreate, db: Session = Depends(get_db)):
    return services.create_account(db, account)

@financeRouter.get("/{account_id}", response_model=AccountOut)
def get_account(account_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    account = services.get_account_by_id(db, account_id)
    if not account:
        raise HTTPException(status_code=404, detail="account not found")
    return account

@financeRouter.get("/user/{userId}")
def get_accountByUserId(userId: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return services.get_account_by_userId(db, userId)

@financeRouter.delete("/{account_id}")
def delete_user(account_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    deleted = services.delete_account_by_id(db, account_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Account not found")
    return {"message": "Account deleted"}