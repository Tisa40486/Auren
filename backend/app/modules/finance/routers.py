from fastapi import APIRouter, HTTPException
from app.core.database import SessionLocal
from app.modules.finance.schemas import AccountCreate, AccountOut
from app.modules.finance import services

financeRouter = APIRouter(
    prefix="/finance",
    tags=["finance"]
)
db = SessionLocal()

@financeRouter.get("/")
def get_accounts():
    return services.get_all_accounts(db)

@financeRouter.post("/accounts")
def create_account(account: AccountCreate):
    return services.create_account(db, account)

@financeRouter.get("/{account_id}", response_model=AccountOut)
def get_account(account_id: int):
    account = services.get_account_by_id(db, account_id)
    if not account:
        raise HTTPException(status_code=404, detail="account not found")
    return account
    
@financeRouter.delete("/{account_id}")
def delete_user(account_id: int):
    deleted = services.delete_account_by_id(db, account_id)
    if not deleted:
            raise HTTPException(status_code=404, detail="Account not found")
    return {"message": "Account deleted"}