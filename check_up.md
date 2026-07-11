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

- sopt a container
docker compose stop <container>

- shut down entire project (removes containers and network; keeps volumes and images)
docker compose down

- removes all containers, all volumes and all networks; (keeps images)
docker compose down -v



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