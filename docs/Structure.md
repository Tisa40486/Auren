# Auren

> **An all-in-one personal management application** that combines finance, project management, and scheduling into a single premium mobile experience inspired by Swiss private banking.

---

# 📱 Overview

Auren is a native iOS application designed to centralize every aspect of personal productivity:

- 💰 Personal Finance
- 📋 Project Management
- 📅 Calendar & Scheduling
- 📊 Daily Dashboard

The goal is to replace multiple applications (Money Manager, Trello, Todoist, Google Calendar, etc.) with a single, elegant ecosystem.

---

# 🏗 Technology Stack

## Frontend

| Technology | Purpose |
|------------|---------|
| SwiftUI | User Interface |
| MVVM | Architecture Pattern |
| Combine | Reactive Programming |
| Swift Package Manager | Dependency Management |

---

## Backend

| Technology | Purpose |
|------------|---------|
| Python 3.14 | Programming Language |
| FastAPI | REST API |
| SQLAlchemy 2 | ORM |
| Pydantic v2 | Data Validation |
| Alembic | Database Migrations |
| PostgreSQL | Primary Database |
| Redis | Cache |
| JWT | Authentication |
| Docker | Containerization |

---

## Development Tools

- Git
- GitHub
- GitHub Actions
- Ruff
- Black
- Mypy
- Pytest

---

# 📁 Project Structure

```text
auren/

├── backend/

├── ios/

├── docs/

├── docker/

├── scripts/

└── .github/
    └── workflows/
```

---

# 🐍 Backend

## Folder Structure

```text
backend/

app/

├── main.py

├── core/

├── modules/

└── shared/

tests/

alembic/

docker-compose.yml

requirements.txt

.env
```

---

# ⚙️ Core

Shared components used across the application.

```text
core/

config.py

database.py

security.py

dependencies.py
```

---

# 📦 Modules

Each business domain is fully isolated.

```text
modules/

auth/

users/

finance/

projects/

calendar/

dashboard/

notifications/

settings/
```

---

# Example Module Structure

```text
finance/

models.py

schemas.py

service.py

router.py
```

Architecture:

```text
Router
    │
Service
    │
Database
```

Dependencies always flow downward. No separate repository layer — the service talks directly to the database via SQLAlchemy.

---

# 🔗 REST API

Versioned from day one.

```text
/api/v1

/auth

/users

/finance

/projects

/calendar

/dashboard

/settings
```

---

# 🏛 Backend Architecture

```text
Route
    │
Router (endpoint)
    │
Service
    │
Database
```

---

# 📂 Shared Layer

Reusable resources shared across all modules.

```text
shared/

schemas.py

utils.py

constants.py

enums.py
```

---

# 📱 iOS Architecture

Built using **SwiftUI + MVVM**.

```text
ios/

Auren/

Core/

Features/

Shared/

Assets/
```

---

# 🧱 Core

Global components shared across every feature.

```text
Core/

Networking/

Storage/

Theme/

Components/

Router/

Extensions/

Services/
```

---

# 📂 Features

```text
Authentication/

Dashboard/

Finance/

Projects/

Calendar/

Settings/
```

Each feature is completely self-contained.

---

# Example Feature Structure

```text
Finance/

Views/

Screens/

ViewModels/

Models/

Services/

Components/

Resources/
```

---

# 🎨 Design System

Reusable UI components.

```text
Components/

AUButton

AUCard

AUInput

AUText

AUAmount

AUBadge

AUSection

AUChart

AUNavigationBar
```

---

# 🎨 Theme

```text
Theme/

Colors.swift

Typography.swift

Spacing.swift

Radius.swift

Icons.swift

Animations.swift
```

---

# 🎨 Color Palette

| Element | Color |
|----------|--------|
| Background | #0A0A0B |
| Surface | #131315 |
| Border | #232326 |
| Primary Text | #EDEBE6 |
| Secondary Text | #8A867D |
| Gold Accent | #C9A667 |
| Bronze Accent | #B8946A |
| Positive | #6B9080 |
| Negative | #A8564F |

---

# ✒️ Typography

### Brand & Headings

Fraunces

### Body Text

Inter

### Numbers & Currency

IBM Plex Mono

---

# 🗄 Database

## Main Tables

```text
users

sessions

settings

accounts

transactions

categories

budgets

projects

project_columns

tasks

calendar_events

notifications

attachments
```

---

# 💰 Finance Module

Hierarchy

```text
Account

↓

Transaction

↓

Category

↓

Budget

↓

Statistics
```

Features

- Multiple Accounts
- Expenses & Income
- Categories
- Monthly Budgets
- Financial Analytics
- Spending Charts
- Monthly Overview

---

# 📋 Projects Module

```text
Project

↓

Column

↓

Task

↓

Checklist

↓

Attachment

↓

Comment
```

Features

- Kanban Board
- List View
- Progress Tracking
- Priorities
- Labels
- Due Dates

---

# 📅 Calendar Module

```text
Event

↓

Reminder

↓

Recurrence

↓

Linked Project

↓

Linked Task
```

Features

- Daily View
- Weekly View
- Monthly View
- Smart Reminders
- Project Integration

---

# 📊 Dashboard

The dashboard contains **no business logic**.

It simply aggregates data from every module.

```text
Finance

+

Projects

+

Calendar
```

Dashboard Widgets

- Today's Spending
- Remaining Budget
- Upcoming Tasks
- Today's Events
- Overall Progress

---

# 🔐 Authentication

- JWT Authentication
- Refresh Tokens
- Sign in with Apple
- Face ID
- Touch ID
- Biometric Lock

---

# 🧩 Services

```text
FinanceService

ProjectService

CalendarService

DashboardService

NotificationService

StatisticsService
```

Each service communicates directly with the database through SQLAlchemy models — no intermediate repository layer.

---

# 🔄 Data Flow

Always separate persistence models from API responses.

```text
Database Model (models.py)

↓

Schema (schemas.py)

↓

API Response
```

SQLAlchemy models should never be returned directly.

---

# 🌍 Environments

```text
.env.development

.env.staging

.env.production
```

---

# 🐳 Docker

```text
backend

postgres

redis

adminer
```

---

# 🚀 CI/CD Pipeline

Every push triggers:

```text
Lint

↓

Tests

↓

Docker Build

↓

Migration Validation

↓

Deployment
```

---

# 📚 Documentation

```text
docs/

architecture/

api/

branding/

database/

decisions/

roadmap/
```

---

# 🛣 Development Roadmap

## Phase 1 — Foundation

- Authentication
- Database
- API
- Theme
- Navigation

---

## Phase 2 — Finance

- Accounts
- Transactions
- Categories
- Budgets
- Charts & Analytics

---

## Phase 3 — Projects

- Kanban Boards
- Checklists
- Attachments
- Comments

---

## Phase 4 — Calendar

- Events
- Reminders
- Task Synchronization

---

## Phase 5 — Dashboard

- Daily Overview
- Widgets
- Statistics

---

## Phase 6 — Premium Features

- iOS Widgets
- Live Activities
- Siri Shortcuts
- Smart Notifications
- Cloud Backup
- Offline Mode
- PDF Export
- CSV Export

---

# 📈 Final System Architecture

```text
                           SwiftUI
                              │
                         REST API
                              │
                      FastAPI (Python)
                              │
──────────────────────────────────────────────────────────
│                         Core                           │
│ Auth │ Users │ Settings │ Shared │ Security            │
──────────────────────────────────────────────────────────
│ Finance │ Projects │ Calendar │ Dashboard │ Notifications │
──────────────────────────────────────────────────────────
│ PostgreSQL │ Redis │ Object Storage │
──────────────────────────────────────────────────────────
```

---

# 🎯 Design Principles

Auren is built around three core principles:

- **Minimalism** — Clean interfaces with generous whitespace.
- **Modularity** — Every feature is independent and scalable.
- **Maintainability** — An architecture designed to comfortably scale beyond **100,000+ lines of code** without major refactoring.