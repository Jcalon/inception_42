NAME = inception

all: prune build

build:
	@echo "Building configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up --build

stop:
	@echo "Stopping configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml down

clean: stop
	@echo "Cleaning configuration ${NAME}\n"
	@rm -rf ~/Desktop/inception

prune: clean
        @docker system prune -f

.PHONY: all build stop clean
