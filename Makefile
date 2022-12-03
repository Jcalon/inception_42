NAME = inception

all: down build

build:
	@echo "Building configuration ${NAME}\n"
	@bash srcs/requirements/wordpress/tools/mkdir_data.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@echo "Stopping configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

clean: down
	@echo "Cleaning configuration ${NAME}\n"
	@docker system prune -f
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/Desktop/inception

fclean: clean
	@docker stop $(docker ps -qa)
	@docker rm $(docker ps -qa)
	@docker rmi -f $(docker images -qa)
	@docker volume rm $(docker volume ls -q)
	@docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all build stop clean
