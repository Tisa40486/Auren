from fastapi import FastAPI
from database.database import engine, SessionLocal, Base
from routers import users

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(users.router)

@app.get("/")
def read_root():
    return {"message": "Hello World From Auren"}