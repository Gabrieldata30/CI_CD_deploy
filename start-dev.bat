@echo off
setlocal

REM Ejecuta frontend (Next.js) y backend (Spring Boot) en ventanas separadas.
REM Uso: doble clic o ejecutar .\start-dev.bat desde la raiz del repo.

set "ROOT=%~dp0"
set "FRONT=%ROOT%flowbuilder-frontend"
set "BACK=%ROOT%Soft2Proj-backend-master\Soft2Proj-backend-master"

if not exist "%FRONT%\package.json" (
  echo [ERROR] No se encontro el frontend en: %FRONT%
  pause
  exit /b 1
)

if not exist "%BACK%\pom.xml" (
  echo [ERROR] No se encontro el backend en: %BACK%
  pause
  exit /b 1
)

echo Iniciando backend y frontend...
echo Frontend esperado en http://localhost:3000
echo Backend esperado en http://localhost:8080

start "Backend - Spring Boot" cmd /k "cd /d ""%BACK%"" && .\mvnw.cmd spring-boot:run"

if exist "%FRONT%\node_modules" (
  start "Frontend - Next.js" cmd /k "cd /d ""%FRONT%"" && npm run dev"
) else (
  start "Frontend - Next.js (setup)" cmd /k "cd /d ""%FRONT%"" && npm ci && npm run dev"
)

endlocal
