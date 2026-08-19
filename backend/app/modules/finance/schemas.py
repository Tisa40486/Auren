from app.modules.users.schemas import UserOut
from pydantic import BaseModel


class AccountCreate(BaseModel):
    name: str
    userId: int
    amount: float
    
class AccountOut(BaseModel):
    id: int
    name: str
    userId: int
    amount: float
    user: UserOut
    
    class Config:
        from_attributes = True 