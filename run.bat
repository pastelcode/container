@echo off
set CONTAINER_NAME=compiler-vm

REM Check if the container exists
docker container inspect %CONTAINER_NAME% >nul 2>&1
if errorlevel 1 (
    echo Container "%CONTAINER_NAME%" does not exist.
    echo Please create it first using:
    echo   docker create -it --name %CONTAINER_NAME% -v "%%cd%%:/workspace" compiler-env
    pause
    exit /b
)

REM Check if the container is running
FOR /F "tokens=*" %%I IN ('docker inspect -f "{{.State.Running}}" %CONTAINER_NAME%') DO SET IS_RUNNING=%%I

if "%IS_RUNNING%"=="true" (
    echo Container "%CONTAINER_NAME%" is already running.
    echo Opening a new terminal...
    docker exec -it %CONTAINER_NAME% bash
) else (
    echo Starting container "%CONTAINER_NAME%"...
    docker start -ai %CONTAINER_NAME%
)
