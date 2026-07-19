from sqlalchemy.orm import Session
from passlib.context import CryptContext
from models.userModel import User
from schemas.usersSchema import UserCreate, UserUpdate
from fastapi import HTTPException

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def create_user(db: Session, user: UserCreate) -> User:
    hashed_pw = hash_password(user.password)
    
    db_user = User(
        name=user.name,
        email=user.email,
        password=hashed_pw,
        updated=False
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_all_users(db: Session):
    return db.query(User).all()

def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()

def delete_user_by_id(db: Session, user_id: int) -> bool:
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        return False
    try:
        db.delete(user)
        db.commit()
        return True
    except Exception:
        db.rollback()  
        raise

def update_user(db:Session, user_id: int, userUpdate : UserUpdate):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        return False
    
    updates = userUpdate.model_dump(exclude_unset=True)
    for field, value in updates.items():
        setattr(user, field, value)
    
    user.updated = True
    db.commit()
    db.refresh(user)
    return user