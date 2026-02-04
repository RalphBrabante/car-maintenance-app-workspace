# Car Maintenance App (Dockerized)

This repo provides a Docker Compose stack with three services:
- `app` (Node.js app as a git submodule)
- `db` (MySQL 8.0)
- `nginx` (reverse proxy to the app)

## Prerequisites
- Docker + Docker Compose
- Git

## Getting Started

### 1) Initialize the git submodule

```bash
git submodule init
git submodule update --recursive
```

### 2) Configure environment variables

Defaults are provided in `.env`. Update as needed:
- `MYSQL_ROOT_PASSWORD`
- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`

### 3) Build and run the stack

```bash
docker compose up -d --build
```

### 4) Access the app

- App (via nginx): http://localhost
- MySQL: localhost:3306

## Project Structure

```
.
├── docker-compose.yml
├── nginx/
│   └── default.conf
├── services/
│   └── app/   # git submodule: git@github.com:RalphBrabante/car-maintenance-app.git
└── .env
```

## Notes

- The app is proxied by nginx from port 80 to the app on port 3000.
- MySQL data is stored in a named volume: `mysql_data`.

## Common Commands

Update submodule to latest remote commit:
```bash
git submodule update --remote --merge
```

Stop services:
```bash
docker compose down
```

Remove volumes (WARNING: deletes DB data):
```bash
docker compose down -v
```
