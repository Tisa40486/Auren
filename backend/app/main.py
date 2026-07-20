from fastapi import FastAPI
from app.core.database import engine, Base
from app.modules.users.routers import userRouter
from app.modules.finance.routers import financeRouter

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(userRouter)
app.include_router(financeRouter)

@app.get("/")
def read_root():
    return {"message": "Hello World From Auren"}