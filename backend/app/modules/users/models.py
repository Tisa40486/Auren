from app.core.database import Base
from sqlalchemy import Boolean, Column, Integer, String


class User(Base):
    __tablename__ = "user"
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String, unique=True)
    password = Column(String)
    updated = Column(Boolean) 