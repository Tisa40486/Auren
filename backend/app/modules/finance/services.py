from app.modules.finance.models import Account
from app.modules.finance.schemas import AccountCreate
from passlib.context import CryptContext
from sqlalchemy.orm import Session, joinedload

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
    return db.query(Account).filter(Account.is_active == True).all()

def get_account_by_id(db: Session, account_id: int):
    return db.query(Account).options(joinedload(Account.user)).filter(Account.id == account_id, Account.is_active == True).first()

def get_account_by_userId(db: Session, user_id: int):
    return db.query(Account).options(joinedload(Account.user)).filter(Account.userId == user_id, Account.is_active == True).all()

def delete_account_by_id(db: Session, account_id: int):
    account = db.query(Account).filter(Account.id == account_id).first()
    if not account:
        return None
    account.is_active = False
    db.commit()
    return account
    