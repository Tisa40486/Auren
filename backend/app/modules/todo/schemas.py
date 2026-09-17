from pydantic import BaseModel


class TaskCreate(BaseModel):
    title: str
    comment: str

    
    
    
class TaskOut(BaseModel):
    title: str
    comment: str
    isFinish: bool
    isActive: bool
    