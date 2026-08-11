# Database

## Tables

```text
users
accounts
transactions
log
alembic_version   # managed by Alembic, not app data
```

## Enums

```text
transactiontype: 
DEPOSIT | WITHDRAWAL | TRANSFER

actiontype: 
TRANSACTION_CREATED | TRANSACTION_FAILED | LOGIN_FAILED
```

## Relationships

```text
User (1) ──< (N) Account
Account (1) ──< (N) Transaction
Account (1) ──< (N) Log
```

## Entity Relationship Diagram

```mermaid
erDiagram
    USERS ||--o{ ACCOUNTS : owns
    ACCOUNTS ||--o{ TRANSACTIONS : has
    ACCOUNTS ||--o{ LOG : generates

    USERS {
        int id PK
        string name
        string email UK
        string password
        bool updated
    }

    ACCOUNTS {
        int id PK
        int userId FK
        string name
        int amount
        string pinCode
        bool is_active
    }

    TRANSACTIONS {
        int id PK
        int accountId FK
        float amount
        enum transactionType
        timestamp createdAt
        string comment
    }

    LOG {
        int id PK
        int accountId FK
        enum actionType
        json details
        string ipAddress
        timestamp createdAt
    }
```