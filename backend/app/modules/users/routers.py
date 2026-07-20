from fastapi import APIRouter,HTTPException
from app.core.database import SessionLocal
from app.modules.users.schemas import UserCreate, UserOut, UserUpdate
from app.modules.users import services

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

db = SessionLocal()

#move get_users to admin
@router.get("/")
def get_users():
    return services.get_all_users(db)

@router.get("/{user_id}", response_model=UserOut)
def get_user(user_id: int):
    user = services.get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.post("/users")
def create_user(user: UserCreate):
    return services.create_user(db, user)

@router.patch("/users/{user_id}")
def update_user(user_id : int, userUpdated: UserUpdate):
    updated = services.update_user(db, user_id, userUpdated)
    if not updated:
        raise HTTPException(status_code=404, detail="User not found")
    return updated
    
@router.delete("/{user_id}")
def delete_user(user_id: int):
    deleted = services.delete_user_by_id(db, user_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted"}