from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.security import verify_password, create_access_token, get_current_user
from app.modules.users.models import User
from app.modules.users import services

authRouter = APIRouter(
    prefix="/auth",
    tags=["auth"])

@authRouter.get("/me")
def read_current_user(current_user: User = Depends(get_current_user)):
    return current_user

@authRouter.post("/login")
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = services.get_user_by_username(db, form_data.username)

    if not user or not verify_password(form_data.password, user.password):
        raise HTTPException(status_code=401, detail="Wrong input, try again or contact support")

    token = create_access_token(data={"sub": str(user.id)})
    return {"access_token": token, "token_type": "bearer"}

