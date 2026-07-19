from pydantic import BaseModel, Field
from typing import Optional
from userModel import User


class account (BaseModel):
    Name:str
    amount:int
    user:User