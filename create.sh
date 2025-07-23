#!/bin/bash

# Set relative path to the workspace folder
WORKSPACE_FOLDER="$(pwd)/workspace"

# Build the Docker image
docker build --platform linux/amd64 -t compiler-env .

# Create the container and bind the workspace folder
docker create -it --platform linux/amd64 --name compiler-vm -v "$WORKSPACE_FOLDER:/workspace" compiler-env
