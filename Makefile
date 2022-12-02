SHELL := /bin/sh

NAME = inception

all: clean build

build:
	@echo -e "Building configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml up --env-file ./srcs/.env --build

stop:
	@echo -e "Stopping configuration ${NAME}\n"
	@docker-compose -f ./srcs/docker-compose.yml down

clean: stop
	@echo -e "Cleaning configuration ${NAME}\n"
	@docker system prune -f

.PHONY: all build stop clean
