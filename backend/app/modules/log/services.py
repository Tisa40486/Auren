from app.core.database import SessionLocal
from app.modules.finance.models import Log
from shared.Enum import ActionType
from typing import Optional


def create_log(accountId: int, actionType: ActionType, details: Optional[dict] = None, ipAddress: Optional[str] = None,) -> None:
    db = SessionLocal()
    try:
        db_log = Log(
            accountId=accountId,
            actionType=actionType,
            details=details,
            ipAddress=ipAddress,
        )
        db.add(db_log)
        db.commit()
    finally:
        db.close()