# Variables
POSTGRES_COMPOSE = docker-compose -f docker/postgres/postgres.docker-compose.yml
MONGO_COMPOSE = docker-compose -f docker/mongodb/mongo.docker-compose.yml
REDIS_COMPOSE = docker-compose -f docker/redis/redis.docker-compose.yml
# Get the compose file based on service
define get-compose
$(if $(filter postgres,$(1)),$(POSTGRES_COMPOSE),\
$(if $(filter mongodb,$(1)),$(MONGO_COMPOSE),\
$(if $(filter redis,$(1)),$(REDIS_COMPOSE),\
$(error Unknown service: $(1)))))
endef

.PHONY: all
all: help

# Run service
.PHONY: run
run:
	@if [ -z "$(SERVICE)" ]; then \
		echo "Error: SERVICE is not set"; \
		echo "Usage: make run SERVICE=postgres|mongodb|redis"; \
		exit 1; \
	fi
	$(call get-compose,$(SERVICE)) up -d

# Stop service
.PHONY: stop
stop:
	@if [ -z "$(SERVICE)" ]; then \
		echo "Error: SERVICE is not set"; \
		echo "Usage: make stop SERVICE=postgres|mongodb|redis"; \
		exit 1; \
	fi
	$(call get-compose,$(SERVICE)) down

# Help
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make run SERVICE=[service] - Start service"
	@echo "  make stop SERVICE=[service] - Stop service"
	@echo "  make help - Show this help message"