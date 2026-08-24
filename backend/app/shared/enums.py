import enum


class ActionType(str, enum.Enum):
    TRANSACTION_CREATED = "transaction_created"
    TRANSACTION_FAILED = "transaction_failed"
    LOGIN_FAILED = "login_failed"
    
class TransactionType(str, enum.Enum):
    DEPOSIT = "deposit"
    WITHDRAWAL = "withdrawal"
    TRANSFER = "transfer"
    
class CategoryType(str, enum.Enum):
    EXPENSE = "expense"
    INCOME = "income"
    BOTH = "both"