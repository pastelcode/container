#!/bin/bash

CONTAINER_NAME="compiler-vm"

# Check if the container exists
if ! docker container inspect "$CONTAINER_NAME" > /dev/null 2>&1; then
    echo "Container \"$CONTAINER_NAME\" does not exist."
    echo "Please create it first using:"
    echo "  docker create -it --name $CONTAINER_NAME -v \"\$(pwd)/workspace:/workspace\" compiler-env"
    exit 1
fi

# Check if the container is running
IS_RUNNING=$(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME")

if [ "$IS_RUNNING" == "true" ]; then
    echo "Container \"$CONTAINER_NAME\" is already running."
    echo "Opening a new terminal..."
    docker exec -it "$CONTAINER_NAME" bash
else
    echo "Starting container \"$CONTAINER_NAME\"..."
    docker start -ai "$CONTAINER_NAME"
fi
