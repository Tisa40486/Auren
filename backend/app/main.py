from fastapi import FastAPI
from app.core.database import engine, SessionLocal, Base
from app.modules.users.routers import router

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(router)

@app.get("/")
def read_root():
    return {"message": "Hello World From Auren"}