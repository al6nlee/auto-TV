#!/bin/bash
STACK_NAME=tv
docker stack deploy ${STACK_NAME} --with-registry-auth --prune \
    -c ./docker-compose.yml
