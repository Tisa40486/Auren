
from pydantic import BaseModel, EmailStr, model_validator


class UserCreate(BaseModel):
    name: str
    email: EmailStr
    password: str
    confirm_password: str

    @model_validator(mode="after")
    def check_passwords_match(self):
        if self.password != self.confirm_password:
            raise ValueError("password and confirm password must be the same, try again")
        return self
    
class UserOut(BaseModel):
    id: int
    name: str
    email: EmailStr

class UserUpdate(BaseModel):
    name: str | None = None
    email: EmailStr | None = None
     
class Config:
        from_attributes = True 