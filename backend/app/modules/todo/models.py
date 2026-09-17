from app.core.database import Base
from sqlalchemy import Boolean, Column, Integer, String


class Task(Base):
    __tablename__ = "task"
    
    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=True)
    comment = Column(String, nullable=True)
    is_finish = Column(Boolean, nullable=False, default=False)
    is_active = Column(Boolean, nullable=False, default=False)