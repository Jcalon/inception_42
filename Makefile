NAME = inception

all:
	@echo -e "Launching configuration ${NAME}\n"
	@bash srcs/requirements/wordpress/tools/makedirectory.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@echo -e "Building configuration ${NAME}\n"
	@bash srcs/requirements/wordpress/tools/makedirectory.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@echo -e "Stopping configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@echo -e "Re Building configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@echo -e "Cleaning configuration ${NAME}\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@echo "Cleaning all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
