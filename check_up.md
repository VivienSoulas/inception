- Checks and expands the compose configuration (does not create container)
docker compose config



- Builds all services that have a build: section
docker compose build
- building specific image
docker compose build <name>

- Starts all services
docker compose up
- run only one specific container
docker compose up <container>

- stop a container
docker compose stop <container>

- shut down entire project (removes containers and network; keeps volumes and images)
docker compose down

- removes all containers, all volumes and all networks; (keeps images)
docker compose down -v

- recompose without cache
docker compose build --no-cache <container>

- list images
docker images

- list running dockers
docker ps

- check logs
docker logs <container>

- check volume
docker volume ls
- check specific volume
docker volume inspect <volume_to_inspect>



- check process (while running)
docker exec -it <container_name> bash




.env
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=changeme
MYSQL_ROOT_PASSWORD=ChangeMe

DOMAIN_NAME=vsoulas.42.fr

WP_ADMIN=yolo
WP_ADMIN_PASSWORD=yolopass
WP_ADMIN_EMAIL=admin@vsoulas.42.fr

WP_USER=vsoulas
WP_USER_PASSWORD=mysuperpassword
WP_USER_EMAIL=vsoulas@vsoulas.42.fr



check for port 443 -> docker ps
connect to database -> make bash-mariadb -> mysql -u root (or mysql -u root -p) or mysql -u wpuser -p
show databas -> SHOW DATABASES; -> USE wordpress; -> SHOW TABLES;

check users -> SELECT user_login, user_email FROM wp_users;