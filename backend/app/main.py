from app.core.database import Base, engine, SessionLocal
from app.modules.auth.routers import authRouter
from app.modules.finance.routers import financeRouter
from app.modules.transaction.routers import transactionRouter
from app.modules.users.routers import userRouter
from fastapi import FastAPI
from firebase_admin import db
from app.modules.users.models import User


app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(userRouter)
app.include_router(financeRouter)
app.include_router(transactionRouter)
app.include_router(authRouter)

db_session = SessionLocal()


@app.get("/")
def read_root():
    return {"message": "Hello World From Auren"}

@app.post("/update-status")
def update_status(user_id: int, new_status: str):
    user = db_session.query(User).filter_by(id=user_id).first()
    user.status = new_status
    db_session.commit()
    

    ref = db.reference(f'users/{user_id}')
    ref.set({'status': new_status})
    
    return {"message": "Success"}