@echo off

REM Build Windows 64-bit version of FastClaw

echo Building Windows 64-bit version of FastClaw...

REM Create output directory if it doesn't exist
if not exist "build" mkdir build

REM Build the binary
set OUTPUT_FILE=build\fastclaw.exe
go build -o %OUTPUT_FILE% -ldflags="-s -w" -buildvcs=false ./cmd/fastclaw

REM Check if build succeeded
if %errorlevel% equ 0 (
    echo Build successful! Windows 64-bit binary created at: %OUTPUT_FILE%
) else (
    echo Build failed. Please check the error messages above.
    exit /b 1
)

echo Windows 64-bit build completed.
