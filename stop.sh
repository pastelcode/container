#!/bin/bash

CONTAINER_NAME="compiler-vm"

# Check if the container exists
if ! docker container inspect "$CONTAINER_NAME" > /dev/null 2>&1; then
    echo "Container \"$CONTAINER_NAME\" does not exist."
    exit 1
fi

# Check if the container is running
IS_RUNNING=$(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME")

if [ "$IS_RUNNING" == "true" ]; then
    echo "Stopping container \"$CONTAINER_NAME\"..."
    docker stop "$CONTAINER_NAME"
else
    echo "Container \"$CONTAINER_NAME\" is not running."
fi
