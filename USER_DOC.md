# User Documentation

## What This Project Does

This project starts a small web platform with three services:

- NGINX exposes the website over HTTPS
- WordPress serves the web application
- MariaDB stores the database

The stack is designed to keep data after restarts and rebuilds using Docker named volumes.

## Requirements

- Docker
- Docker Compose
- Make

## Setup

1. Create or update the `.env` file with the required credentials and domain name.
2. Add the domain to your hosts file so it points to `127.0.0.1`.
3. Build and start the project with `make build` and `make up`, or use `make upd` to start it in the background.

## How To Use

After the containers are running, open:

```text
https://<your_domain>
```

You should see the WordPress website served through NGINX over HTTPS.

## Common Commands

- `make ps` shows running containers
- `make logs` shows logs for the whole stack
- `make logs-mariadb` shows MariaDB logs
- `make logs-wordpress` shows WordPress logs
- `make logs-nginx` shows NGINX logs
- `make stop` stops the containers
- `make start` starts stopped containers again
- `make down` removes the containers and network
- `make clean` removes containers and volumes
- `make fclean` removes containers, volumes, images, and stored data

## Notes

- The first start may take a little longer because MariaDB creates the database and WordPress downloads its files.
- If you change the `.env` file, restart the stack so the new values are applied.
- Database and WordPress data are stored in Docker named volumes, so your content will remain after rebuilds.