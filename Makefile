SERVICE_NAME = core
SERVICE_NAME_BASE = ${SERVICE_NAME}-base
SERVICE_NAME_PROD = ${SERVICE_NAME}-product
SERVICE_NAME_DEV = ${SERVICE_NAME}-dev
SERVICE_NAME_RESEARCH = ${SERVICE_NAME}-research
COMMAND_BASE = /bin/bash
COMMAND_PROD = /bin/bash
COMMAND_DEV = /bin/bash
COMMAND_RESEARCH = /bin/bash

GID = $(shell id -g)
UID = $(shell id -u)
GRP = $(shell id -gn)
USR = $(shell id -un)

IMAGE_NAME_BASE = ${SERVICE_NAME}-${USR}-base:1.0.0
IMAGE_NAME_PROD = ${SERVICE_NAME}-${USR}-product:1.0.0
IMAGE_NAME_DEV = ${SERVICE_NAME}-${USR}-dev:1.0.0
IMAGE_NAME_RESERACH = ${SERVICE_NAME}-${USR}-research:latest
WORKDIR_PATH = /opt/${SERVICE_NAME}

CURRENT_PATH = $(shell pwd)
DOCKER_BUILD_CONTEXT_PATH = ./DockerFile

DOCKERFILE_NAME_BASE = Dockerfile_base
DOCKERFILE_NAME_PROD = Dockerfile_product
DOCKERFILE_NAME_DEV = Dockerfile_dev
DOCKERFILE_NAME_RESEARCH = Dockerfile_research
DOCKER_COMPOSE_NAME = Docker_compose.yaml

ENV_FILE_PATH = ${DOCKER_BUILD_CONTEXT_PATH}/.env

ENV_TEXT = "$\
GID=${GID}\n$\
UID=${UID}\n$\
GRP=${GRP}\n$\
USR=${USR}\n$\
IMAGE_NAME_BASE=${IMAGE_NAME_BASE}\n$\
IMAGE_NAME_PROD=${IMAGE_NAME_PROD}\n$\
IMAGE_NAME_DEV=${IMAGE_NAME_DEV}\n$\
IMAGE_NAME_RESERACH=${IMAGE_NAME_RESERACH}\n$\
WORKDIR_PATH=${WORKDIR_PATH}\n$\
CURRENT_PATH=${CURRENT_PATH}\n$\
DOCKER_BUILD_CONTEXT_PATH=${DOCKER_BUILD_CONTEXT_PATH}\n$\
DOCKERFILE_NAME_BASE=${DOCKERFILE_NAME_BASE}\n$\
DOCKERFILE_NAME_PROD=${DOCKERFILE_NAME_PROD}\n$\
DOCKERFILE_NAME_DEV=${DOCKERFILE_NAME_DEV}\n$\
DOCKERFILE_NAME_RESEARCH=${DOCKERFILE_NAME_RESEARCH}\n$\
DOCKER_COMPOSE_NAME=${DOCKER_COMPOSE_NAME}\n$\
"

${ENV_FILE_PATH}:
	printf ${ENV_TEXT} >> ${ENV_FILE_PATH}

env: ${ENV_FILE_PATH}

build-base:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up --build -d ${SERVICE_NAME_BASE}
up-base:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up -d ${SERVICE_NAME_BASE}
exec-base: 
	DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} exec ${SERVICE_NAME_BASE} ${COMMAND_BASE}
start-base:
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} start ${SERVICE_NAME_BASE}
down-base: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} down
run-base: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} run ${SERVICE_NAME_BASE} ${COMMAND_BASE}
ls-base: 
	docker compose ls -a

build-prod: build-base
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up --build -d ${SERVICE_NAME_PROD}
up-prod:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up -d ${SERVICE_NAME_PROD}
exec-prod: 
	DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} exec ${SERVICE_NAME_PROD} ${COMMAND_PROD}
start-prod:
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} start ${SERVICE_NAME_PROD}
down-prod: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} down
run-prod: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} run ${SERVICE_NAME_PROD} ${COMMAND_PROD}
ls-prod: 
	docker compose ls -a

build-dev: build-prod
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up --build -d ${SERVICE_NAME_DEV}
up-dev:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up -d ${SERVICE_NAME_DEV}
exec-dev: 
	DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} exec ${SERVICE_NAME_DEV} ${COMMAND_DEV}
start-dev:
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} start ${SERVICE_NAME_DEV}
down-dev: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} down
run-dev: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} run ${SERVICE_NAME_DEV} ${COMMAND_DEV}
ls-dev: 
	docker compose ls -a

build-research: 
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up --build -d ${SERVICE_NAME_RESEARCH}
up-research:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} up -d ${SERVICE_NAME_RESEARCH}
exec-research: 
	DOCKER_BUILDKIT=1 docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} exec ${SERVICE_NAME_RESEARCH} ${COMMAND_RESEARCH}
start-research:
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} start ${SERVICE_NAME_RESEARCH}
down-research: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} down
run-research: 
	docker compose -f ${DOCKER_BUILD_CONTEXT_PATH}/${DOCKER_COMPOSE_NAME} run ${SERVICE_NAME_RESEARCH} ${COMMAND_RESEARCH}
ls-research: 
	docker compose ls -a