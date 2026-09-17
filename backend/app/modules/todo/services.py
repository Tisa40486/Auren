from app.modules.todo.models import Task
from app.modules.todo.schemas import TaskCreate
from sqlalchemy.orm import Session


def get_all_task(db: Session):
    return db.query(Task).filter(Task.is_active == True).all()


def create_task(db: Session, task: TaskCreate) -> Task:
    
    db_task = Task(
        title = task.title,
        comment = task.comment,
    )
    db_task.is_active = True
    db_task.is_finish = False
    
    db.add(db_task)
    db.commit()
    db.refresh(db_task)
    return db_task


