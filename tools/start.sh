#!/bin/bash
STACK_NAME=tv
docker stack deploy ${STACK_NAME} --with-registry-auth --prune \
    -c ./compose/services.yml \
    -c ./compose/override.yml \
    -c ./compose/network.yml
