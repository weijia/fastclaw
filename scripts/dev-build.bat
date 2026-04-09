@echo off

REM Build web
cd web
if exist "%npm_prefix%\pnpm.cmd" (
    pnpm build
) else if exist "%npm_prefix%\npm.cmd" (
    npm run build
) else (
    echo Error: Neither pnpm nor npm found. Please install Node.js and pnpm.
    exit /b 1
)
cd ..

REM Create tmp directory if it doesn't exist
if not exist "tmp" mkdir tmp

REM Copy web output to embed dir
if exist "web\out" (
    if exist "internal\setup\web" rmdir /s /q "internal\setup\web"
    xcopy "web\out" "internal\setup\web" /E /I
    echo Web files copied to internal\setup\web
) else (
    echo Error: web\out directory not found. Web build may have failed.
    exit /b 1
)

REM Build Go binary
go build -ldflags "-X main.version=dev" -o tmp\fastclaw.exe ./cmd/fastclaw
if %errorlevel% equ 0 (
    echo Go binary built successfully
) else (
    echo Error: Go build failed.
    exit /b 1
)