NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

# build image(s)
# ----------------------------------------------
build:
	$(COMPOSE) build

rebuild:
	$(COMPOSE) build --no-cache

mariadb:
	$(COMPOSE) build mariadb

wordpress:
	$(COMPOSE) build wordpress

nginx:
	$(COMPOSE) build nginx
# ----------------------------------------------


# run container(s)
# ----------------------------------------------
up:
	$(COMPOSE) up

# run detached mode
upd:
	$(COMPOSE) up -d
# ----------------------------------------------


stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:
	$(COMPOSE) down -v --rmi all

re: fclean rebuild up

# logs
# ----------------------------------------------
logs:
	$(COMPOSE) logs -f

logs-mariadb:
	$(COMPOSE) logs -f mariadb

logs-wordpress:
	$(COMPOSE) logs -f wordpress

logs-nginx:
	$(COMPOSE) logs -f nginx


# container shells
# ----------------------------------------------
bash-mariadb:
	docker exec -it mariadb bash

bash-wordpress:
	docker exec -it wordpress bash

bash-nginx:
	docker exec -it nginx bash
# ----------------------------------------------


# infos
# ----------------------------------------------
ps:
	docker ps

images:
	docker images

volumes:
	docker volume ls

networks:
	docker network ls

config:
	$(COMPOSE) config


.PHONY: all build rebuild mariadb wordpress nginx \
	up upd stop start down clean fclean re \
	logs logs-mariadb logs-wordpress logs-nginx \
	bash-mariadb bash-wordpress bash-nginx \
	ps images volumes networks config