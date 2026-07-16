NAME		= inception

LOGIN 		:= $(shell whoami)
DC			= docker compose -f srcs/docker-compose.yml
DATA_PATH	= /home/$(LOGIN)/data

all: up

data:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress


# build image(s)
# ----------------------------------------------
build:
	$(DC) build

rebuild:
	$(DC) build --no-cache

mariadb:
	$(DC) build mariadb

wordpress:
	$(DC) build wordpress

nginx:
	$(DC) build nginx
# ----------------------------------------------


# run container(s)
# ----------------------------------------------
up: data
	$(DC) up

# run detached mode
upd: data
	$(DC) up -d
# ----------------------------------------------


stop:
	$(DC) stop

start:
	$(DC) start

down:
	$(DC) down

clean:
	$(DC) down -v

fclean:
	$(DC) down -v --rmi all
	sudo rm -rf $(DATA_PATH)

re: fclean rebuild



# logs
# ----------------------------------------------
logs:
	$(DC) logs -f

logs-mariadb:
	$(DC) logs -f mariadb

logs-wordpress:
	$(DC) logs -f wordpress

logs-nginx:
	$(DC) logs -f nginx


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
	$(DC) config


.PHONY: all data build rebuild mariadb wordpress nginx \
	up upd stop start down clean fclean re \
	logs logs-mariadb logs-wordpress logs-nginx \
	bash-mariadb bash-wordpress bash-nginx \
	ps images volumes networks config