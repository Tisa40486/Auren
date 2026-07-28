from fastapi import APIRouter, HTTPException, Depends
from app.core.database import SessionLocal
from app.modules.users.schemas import UserCreate, UserOut, UserUpdate
from app.modules.users import services
from app.core.security import get_current_user


userRouter = APIRouter(
    prefix="/users",
    tags=["users"]
)

db = SessionLocal()

@userRouter.get("/")
def get_users(current_user: User = Depends(get_current_user)):
    return services.get_all_users(db)

@userRouter.get("/{user_id}", response_model=UserOut)
def get_user(user_id: int):
    user = services.get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@userRouter.post("/users")
def create_user(user: UserCreate):
    return services.create_user(db, user)

@userRouter.patch("/users/{user_id}")
def update_user(user_id : int, userUpdated: UserUpdate, current_user: User = Depends(get_current_user)):
    updated = services.update_user(db, user_id, userUpdated)
    if not updated:
        raise HTTPException(status_code=404, detail="User not found")
    return updated
    
@userRouter.delete("/{user_id}")
def delete_user(user_id: int, current_user: User = Depends(get_current_user)):
    deleted = services.delete_user_by_id(db, user_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted"}