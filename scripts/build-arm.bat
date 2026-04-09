@echo off

REM Build ARM64 version of FastClaw

echo Building ARM64 version of FastClaw...

REM Set environment variables for ARM64 build
set GOOS=linux
set GOARCH=arm64

REM Create output directory if it doesn't exist
if not exist "build" mkdir build

REM Build the binary
set OUTPUT_FILE=build\fastclaw-arm64
go build -o %OUTPUT_FILE% -ldflags="-s -w" -buildvcs=false ./cmd/fastclaw

REM Check if build succeeded
if %errorlevel% equ 0 (
    echo Build successful! ARM64 binary created at: %OUTPUT_FILE%
) else (
    echo Build failed. Please check the error messages above.
    exit /b 1
)

REM Reset environment variables
set GOOS=
set GOARCH=

echo ARM64 build completed.
