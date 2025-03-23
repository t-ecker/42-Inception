COMPOSE_FILE = ./srcs/docker-compose.yml

DC = docker-compose -f $(COMPOSE_FILE)

all:	up

build:
	mkdir -p ~/data/wp-db
	mkdir -p ~/data/wp-sites
	mkdir -p ~/data/portainer
	$(DC) build

up:	build
	$(DC) up -d

down:
	$(DC) down

clean:
	$(DC) down --rmi all --volumes --remove-orphans

re: down up