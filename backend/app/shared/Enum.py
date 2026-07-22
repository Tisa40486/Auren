import enum

class ActionType(str, enum.Enum):
    TRANSACTION_CREATED = "transaction_created"
    TRANSACTION_FAILED = "transaction_failed"
    LOGIN_FAILED = "login_failed"