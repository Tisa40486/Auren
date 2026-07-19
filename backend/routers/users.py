from fastapi import APIRouter,HTTPException
from database.database import engine, SessionLocal, Base
from schemas.usersSchema import UserCreate
from models.userModel import User

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

@router.get("/")
def get_users():
    db = SessionLocal()
    users = db.query(User).all()
    if users == []:
        raise HTTPException(status_code=404, detail="Users not found")
    return users

@router.get("/users/{user_id}")
def get_user(user_id: int): 
    db = SessionLocal()
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.post("/users")
def create_user(user: UserCreate):
    db = SessionLocal()
    db_user = User(name=user.name, email=user.email)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user