NAME = inception

all: down build

build:
	@echo "Building configuration ${NAME}\n"
	@bash srcs/requirements/wordpress/tools/mkdir_data.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@echo "Stopping configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

clean: stop
	@echo "Cleaning configuration ${NAME}\n"
	@docker system prune -f
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/Desktop/inception

.PHONY: all build stop clean
