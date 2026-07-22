from pydantic import BaseModel, EmailStr, model_validator
from typing import Optional
from app.modules.users.schemas import UserOut

class AccountCreate(BaseModel):
    name: str
    userId: int
    amount: int
    pinCode: str
    confirm_pinCode: str
    @model_validator(mode="after")
    def check_passwords_match(self):
        if self.pinCode != self.confirm_pinCode:
            raise ValueError("Pin code and confirm pin code must be the same, try again")
        return self
    
class AccountOut(BaseModel):
    name: str
    userId: int
    amount: int
    user: UserOut
    
    class Config:
        from_attributes = True 