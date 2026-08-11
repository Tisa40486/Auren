# Architecture

## Stack

**Backend**

| Technology | Purpose |
|---|---|
| Python 3.14 | Language |
| FastAPI | REST API |
| SQLAlchemy 2 | ORM |
| Pydantic v2 | Data validation |
| Alembic | Database migrations |
| PostgreSQL | Primary database |
| Redis | Cache |
| JWT | Authentication |
| Docker | Containerization |

**Frontend**

| Technology | Purpose |
|---|---|
| SwiftUI | UI |
| MVVM | Architecture pattern |
| Combine | Reactive programming |
| Swift Package Manager | Dependency management |

**Dev tools**

Git, GitHub Actions, Ruff, Black, Mypy, Pytest

---

## Backend structure

```text
backend/
├── app/
│   ├── main.py
│   ├── core/          # config, database, security, dependencies
│   ├── modules/        # auth, users, finance, projects, calendar, dashboard, notifications, settings
│   └── shared/          # schemas, utils, constants, enums
├── tests/
├── alembic/
├── docker-compose.yml
└── requirements.txt
```

**Layering** — every module follows the same flow, no repository layer:

```text
Router → Service → Database (SQLAlchemy)
```

**Data flow** — persistence models are never returned directly:

```text
Database Model (models.py) → Schema (schemas.py) → API Response
```

**REST API** — versioned from day one: `/api/v1/{auth, users, finance, projects, calendar, dashboard, settings}`

---

## iOS structure

```text
Auren/
└── Auren/
    ├── Assets.xcassets       # App icon, accent color, image assets
    ├── AurenApp.swift        # App entry point
    ├── ContentView.swift
    ├── Enum/
    │   ├── NetworkError.swift
    │   └── TransactionType.swift
    ├── Models/
    │   ├── FinancialAccount.swift
    │   ├── FinancialAccountResponse.swift
    │   ├── TransactionResponse.swift
    │   └── User.swift
    ├── Services/
    │   ├── APIClient.swift
    │   └── SessionManager.swift
    ├── ViewModels/
    │   ├── AccountDetailViewModel.swift
    │   ├── AccountListViewModel.swift
    │   ├── CreateAccountViewModel.swift
    │   ├── CreateFinancialAccountViewModel.swift
    │   ├── CreateTransactionViewModel.swift
    │   ├── HomeViewModel.swift
    │   └── LoginViewModel.swift
    └── Views/
        ├── Finance/
        ├── Home/
        ├── Login/
        └── RootView.swift
```

> ⚠️ `CreateAccountViewModel` and `CreateFinancialAccountViewModel` currently overlap in purpose — to review and possibly merge.

---

## Environments

```text
.env.development
.env.staging
.env.production
```

## Docker services

`backend` · `postgres` · `redis` · `adminer`

## CI/CD

```text
Lint → Tests → Docker Build → Migration Validation → Deployment
```

---

## System overview

```text
                     SwiftUI
                        │
                   REST API (v1)
                        │
                FastAPI (Python)
   ┌──────────────────────────────────────────┐
   │  Core: Auth · Users · Settings · Security│
   ├──────────────────────────────────────────┤
   │ Finance · Projects · Calendar · Dashboard│
   │           · Notifications                │
   ├──────────────────────────────────────────┤
   │  PostgreSQL · Redis · Object Storage     │
   └──────────────────────────────────────────┘