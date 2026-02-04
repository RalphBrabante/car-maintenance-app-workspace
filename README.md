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

## Debugging (VS Code + Docker)

Start the stack with the debug override:
```bash
docker compose -f docker-compose.yml -f docker-compose.debug.yml up -d --build
```

Then in VS Code run the debugger:
- `Attach to Docker (Node)`

This attaches to `localhost:9229` and maps the container path `/app` to `services/app`.

## Project Structure

```
.
├── docker-compose.yml
├── docker-compose.debug.yml
├── nginx/
│   └── default.conf
├── .vscode/
│   └── launch.json
├── services/
│   └── app/   # git submodule: git@github.com:RalphBrabante/car-maintenance-app.git
└── .env
```

## Notes

- The app is proxied by nginx from port 80 to the app on port 3000.
- MySQL data is stored in a named volume: `mysql_data`.

## DigitalOcean (Low/Dev - Cheapest Droplet)

Recommended baseline:
- Droplet: 1 vCPU / 1 GB RAM
- Docker + Compose
- Keep MySQL on the droplet

Optimizations applied in `docker-compose.yml`:
- `restart: unless-stopped` for `app` and `nginx`
- Lightweight resource limits for a small droplet

MySQL tuning in `db/conf/custom.cnf`:
- `innodb_buffer_pool_size = 128M`
- `max_connections = 75`

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
