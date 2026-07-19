from fastapi import APIRouter,HTTPException
from database.database import engine, SessionLocal, Base, get_db
from schemas.usersSchema import UserCreate, UserOut, UserUpdate
from models.userModel import User
from services import userService 
router = APIRouter(
    prefix="/users",
    tags=["users"]
)
db = SessionLocal()

#move get_users to admin
@router.get("/")
def get_users():
    return userService.get_all_users(db)

@router.get("/{user_id}", response_model=UserOut)
def get_user(user_id: int):
    user = userService.get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@router.post("/users")
def create_user(user: UserCreate):
    return userService.create_user(db, user)

@router.patch("/users/{user_id}")
def update_user(user_id : int, userUpdated: UserUpdate):
    updated = userService.update_user(db, user_id, userUpdated)
    if not updated:
        raise HTTPException(status_code=404, detail="User not found")
    return updated
    
@router.delete("/{user_id}")
def delete_user(user_id: int):
    deleted = userService.delete_user_by_id(db, user_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted"}