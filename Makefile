.PHONY: run migrate down dependencies

COMPOSE = docker-compose

default: run

run: dependencies migrate
	$(COMPOSE) up -d api

dependencies:
	$(COMPOSE) up -d db

migrate:
	$(COMPOSE) run --rm api bash -c "bundle exec rake db:create db:migrate"

down:
	$(COMPOSE) stop && $(COMPOSE) rm -f
