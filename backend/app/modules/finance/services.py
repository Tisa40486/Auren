from sqlalchemy.orm import Session, joinedload
from app.modules.finance.models import Account
from app.modules.finance.schemas import AccountCreate
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_pinCode(pinCode: str) -> str:
    return pwd_context.hash(pinCode)

def create_account(db: Session, account: AccountCreate) -> Account:
    hashed_pin = hash_pinCode(account.pinCode)
    
    db_account = Account(
        userId = account.userId,
        name = account.name,
        amount = 0,
        pinCode = hashed_pin
        )
    
    db.add(db_account)
    db.commit()
    db.refresh(db_account)
    return db_account

def get_all_accounts(db: Session):
    return db.query(Account).all()

def get_account_by_id(db: Session, account_id: int):
    return db.query(Account).options(joinedload(Account.user)).filter(Account.id == account_id).first()

def delete_account_by_id(db:Session, account_id: int) -> bool:
    account = db.query(Account).options(joinedload(Account.user)).filter(Account.id == account_id).first()
    if not account:
        return False
    try:
        db.delete(account)
        db.commit()
        return True
    except Exception:
        db.rollback()  
        raise
    