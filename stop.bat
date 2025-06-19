@echo off
set CONTAINER_NAME=compiler-vm

REM Check if container exists
docker container inspect %CONTAINER_NAME% >nul 2>&1
if errorlevel 1 (
    echo Container "%CONTAINER_NAME%" does not exist.
    pause
    exit /b
)

REM Check if the container is running
FOR /F "tokens=*" %%I IN ('docker inspect -f "{{.State.Running}}" %CONTAINER_NAME%') DO SET IS_RUNNING=%%I

if "%IS_RUNNING%"=="true" (
    echo Stopping container "%CONTAINER_NAME%"...
    docker stop %CONTAINER_NAME%
) else (
    echo Container "%CONTAINER_NAME%" is not running.
)

pause
