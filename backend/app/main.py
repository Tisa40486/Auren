from app.core.database import Base, engine
from app.modules.auth.routers import authRouter
from app.modules.finance.routers import financeRouter
from app.modules.transaction.routers import transactionRouter
from app.modules.users.routers import userRouter
from fastapi import FastAPI

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(userRouter)
app.include_router(financeRouter)
app.include_router(transactionRouter)
app.include_router(authRouter)

@app.get("/")
def read_root():
    return {"message": "Hello World From Auren"}