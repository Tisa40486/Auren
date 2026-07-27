
from app.core.database import SessionLocal
from app.modules.log.models import Log
from app.shared.enums import ActionType


def create_log(accountId: int, actionType: ActionType, details: dict | None = None, ipAddress: str | None = None,) -> None:
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