from app.modules.users.schemas import UserOut
from pydantic import BaseModel, model_validator


class AccountCreate(BaseModel):
    name: str
    userId: int
    amount: float
    pinCode: str
    confirm_pinCode: str
    @model_validator(mode="after")
    def check_passwords_match(self):
        if self.pinCode != self.confirm_pinCode:
            raise ValueError("Pin code and confirm pin code must be the same, try again")
        return self
    
class AccountOut(BaseModel):
    id: int
    name: str
    userId: int
    amount: float
    user: UserOut
    
    class Config:
        from_attributes = True 