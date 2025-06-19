@echo off
REM Set relative path to the workspace folder
set WORKSPACE_FOLDER=%cd%\workspace

REM Build the Docker image
docker build -t compiler-env .

REM Create the container and bind the workspace folder
docker create -it --name compiler-vm -v "%WORKSPACE_FOLDER%:/workspace" compiler-env
