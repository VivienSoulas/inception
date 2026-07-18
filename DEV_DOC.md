# Developer Documentation

## Overview

This repository implements the 42 Inception subject with a minimal Docker-based web stack.

The application is split into three services:

- NGINX acts as the public entry point and handles HTTPS encryption and decryption
- WordPress runs PHP-FPM and handles CMS (Content Management System) logic
- MariaDB stores the application data

The services are orchestrated with Docker Compose and connected through the `inception` network.

## File Layout

- `srcs/docker-compose.yml` defines the services, network, and persistent named volumes
- `srcs/requirements/NGINX/` contains the NGINX image, configuration, and startup script
- `srcs/requirements/WordPress/` contains the WordPress image and initialization script
- `srcs/requirements/MariaDB/` contains the MariaDB image, configuration, and initialization script
- `Makefile` wraps the usual Docker commands and prepares the host data directories

## Service Behavior

### NGINX

NGINX listens on port `443`, generates a self-signed certificate if needed, rewrites the configured domain into the NGINX configuration, and proxies PHP requests to the WordPress container on port `9000`.

### WordPress

WordPress waits until MariaDB is reachable, downloads WordPress if needed, generates `wp-config.php`, installs the site, creates the admin and normal author user, and then starts PHP-FPM in the foreground.

### MariaDB

MariaDB initializes its database directory on the first run, starts a temporary server to create the database and users, stores a marker file to avoid repeating the setup, and then launches the database server normally.

## Data Persistence

The compose file maps Docker named volumes to host storage locations under `/home/$LOGIN/data`:

- MariaDB data is stored in `/home/$LOGIN/data/mariadb`
- WordPress files are stored in `/home/$LOGIN/data/wordpress`

The volumes are still named volumes, but Docker uses those host directories as their backing storage.

## Build And Run

Common targets:

- `make build` builds all images
- `make upd` starts the full stack in detached mode
- `make up` starts the full stack in the foreground
- `make rebuild` rebuilds without cache
- `make mariadb`, `make wordpress`, `make nginx` build a single image
- `make down` stops the stack and removes the network and containers
- `make clean` also removes volumes
- `make fclean` additionally removes images and host data directories

## Environment Variables

The stack depends on environment variables loaded from `.env`. The important values are:

- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `MYSQL_ROOT_PASSWORD`
- `DOMAIN_NAME`
- `WP_ADMIN`
- `WP_ADMIN_PASSWORD`
- `WP_ADMIN_EMAIL`
- `WP_USER`
- `WP_USER_PASSWORD`
- `WP_USER_EMAIL`

The runtime scripts use these values to configure MariaDB, WordPress, and the generated SSL certificate.

## Development Notes

- The stack is intentionally based on Debian bookworm to keep the environment stable.
- Each container uses a dedicated entrypoint script instead of a single shared bootstrap script.
- NGINX is the only exposed service; MariaDB and WordPress stay inside the Docker network.
- The TLS certificate is self-signed and generated on container startup if it does not already exist.
- The WordPress container uses WP-CLI to keep the installation automated and reproducible.

## Validation Tips

Useful checks while developing:

- `make config` to inspect the final compose configuration
- `make ps` to check which containers are running
- `make logs-<service>` to inspect service startup issues
- `make bash-<service>` to inspect files and run service-specific commands inside a container

## Implementation References

- NGINX startup script: `srcs/requirements/NGINX/tools/init_nginx.sh`
- WordPress startup script: `srcs/requirements/WordPress/tools/init_wp.sh`
- MariaDB startup script: `srcs/requirements/MariaDB/tools/init_db.sh`
- Compose configuration: `srcs/docker-compose.yml`