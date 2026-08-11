<div align="center">

# Auren

**One app to manage your life.**

![SwiftUI](https://img.shields.io/badge/SwiftUI-000000?style=for-the-badge&logo=swift&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

<br>

![Status](https://img.shields.io/badge/status-in%20development-yellow?style=flat-square)

![License](https://img.shields.io/badge/license-private-lightgrey?style=flat-square)

</div>

<br>

## Table of Contents

- [Architecture](#architecture)
- [Features](#features)
- [Vision](#vision)
- [Setup](#setup)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)

<br>

## Architecture

Auren's frontend is built with SwiftUI and communicates with a FastAPI backend through a REST API. The backend handles the business logic (users, accounts, transactions) and persists data in a PostgreSQL database. The backend is fully containerized with Docker, with a clear separation between development and production environments.

<br>

## Features

| Status | Feature |
|:---:|---|
| ✅ | User authentication |
| ✅ | Account management (create, view accounts) |
| ✅ | Budget/finance tracking module |
| ✅ | Security audit logs (transactions, failed logins, etc.) |
| 🔜 | Transaction creation from the app |
| 🔜 | Todo list module |
| 🔜 | Production environment (self-hosted, dev/prod separation) |
| 🔜 | Full documentation (module docs, API reference, architecture diagram) |

<br>

## Vision

Auren aims to grow into a complete life-management app, organized around several modules:

<table>
<tr>
<td width="50%" valign="top">

**📊 Dashboard**
- Expense overview
- Sleep & mood graphs

**💰 Expense Tracking**
- Account creation
- Transaction creation
- Tags (friends, group, work, food, etc.)

**✅ Todo**
- Project creation
- Add people to a project
- Task creation
- Tags per project

</td>
<td width="50%" valign="top">

**📅 Agenda**
- Reminders

**😴 Mood & Sleep**
- Module to log mood and sleep

**👥 Contacts**
- Create relationships
- Track last contact & contact frequency
- Type field (friend, close, family)
- Time-since-last-contact indicator
- Link with money spent

</td>
</tr>
</table>

> This is the long-term vision — see [Roadmap](#️roadmap) for what's actively being worked on.

<br>

## Setup

> ⚠️ Detailed setup instructions coming soon.

**Backend**
```bash
cd Backend
docker-compose up
```

**Frontend**

Open the project in Xcode and run on a simulator or device.

<br>

## Project Structure

```
Auren/
├── backend/                # FastAPI backend
│   ├── alembic/            # Database migrations
│   ├── app/
│   │   ├── core/           # Core config, settings
│   │   ├── modules/        # Business logic modules
│   │   ├── shared/         # Shared utilities
│   │   └── main.py         # App entry point
│   ├── test/                # Backend tests
│   └── docker-compose.yml
├── docker/                 # Docker-related assets
├── docs/                   # Project documentation
├── ios/
│   └── Auren/               # SwiftUI frontend
└── readme.md
```

<br>

## Roadmap

- [x] User authentication
- [x] Account management module
- [x] Security audit logs
- [ ] Transaction creation from the app
- [ ] Production environment (self-hosted on dedicated hardware)
- [ ] Dev/prod environment separation
- [ ] Todo list module
- [ ] Full project documentation (module docs, API reference, architecture diagram)

<br>

<div align="center">

Made by Tisa_48

</div>