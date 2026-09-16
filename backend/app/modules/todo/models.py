from app.core.database import Base
from sqlalchemy import Boolean, Column, Integer, String


class Task(Base):
    __tablename__ = "task"
    
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=True)
    comment = Column(String)
    password = Column(String)
    updated = Column(Boolean) 