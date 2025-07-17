#!/bin/bash

# Set relative path to the workspace folder
WORKSPACE_FOLDER="$(pwd)/workspace"

# Build the Docker image
docker build -t compiler-env .

# Create the container and bind the workspace folder
docker create -it --name compiler-vm -v "$WORKSPACE_FOLDER:/workspace" compiler-env
