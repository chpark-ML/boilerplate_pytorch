SERVICE_NAME = core
SERVICE_NAME_BASE = ${SERVICE_NAME}-base
SERVICE_NAME_DEV = ${SERVICE_NAME}-dev
COMMAND_BASE = /bin/bash
COMMAND_DEV = /bin/bash

GID = $(shell id -g)
UID = $(shell id -u)
GRP = $(shell id -gn)
USR = $(shell id -un)

IMAGE_NAME_BASE = ${SERVICE_NAME}-${USR}-base:latest
IMAGE_NAME_DEV = ${SERVICE_NAME}-${USR}-dev:1.0.0
WORKDIR_PATH = /opt/${SERVICE_NAME}

CURRENT_PATH = $(shell pwd)
DOCKER_BUILD_CONTEXT_PATH = ./DockerFile

DOCKERFILE_NAME_BASE = Dockerfile_base
DOCKERFILE_NAME_DEV = Dockerfile_dev
DOCKER_COMPOSE_NAME = Docker_compose.yaml

ENV_FILE_PATH = ${DOCKER_BUILD_CONTEXT_PATH}/.env

ENV_TEXT = "$\
GID=${GID}\n$\
UID=${UID}\n$\
GRP=${GRP}\n$\
USR=${USR}\n$\
IMAGE_NAME_BASE=${IMAGE_NAME_BASE}\n$\
IMAGE_NAME_DEV=${IMAGE_NAME_DEV}\n$\
WORKDIR_PATH=${WORKDIR_PATH}\n$\
CURRENT_PATH=${CURRENT_PATH}\n$\
DOCKER_BUILD_CONTEXT_PATH=${DOCKER_BUILD_CONTEXT_PATH}\n$\
DOCKERFILE_NAME_BASE=${DOCKERFILE_NAME_BASE}\n$\
DOCKERFILE_NAME_DEV=${DOCKERFILE_NAME_DEV}\n$\
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

build-dev: build-base
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
