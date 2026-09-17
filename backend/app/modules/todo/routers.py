from app.core.database import get_db
from app.core.security import get_current_user
from app.modules.todo import services
from app.modules.todo.schemas import TaskCreate
from app.modules.users.models import User
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

todoRouter = APIRouter(
    prefix="/todo",
    tags=["todo"]
)

@todoRouter.get("/tasks")
def get_task(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return services.get_all_task(db)

@todoRouter.post("/")
def create_task(task: TaskCreate, db: Session = Depends(get_db)):
    return services.create_task(db, task)