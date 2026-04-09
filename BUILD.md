# Build Guide

This guide explains how to build FastClaw from source, including the web interface.

## Prerequisites

### Required Tools
- **Go** (version 1.25 or later)
- **Node.js** (version 18 or later)
- **pnpm** (recommended) or **npm**

### Windows Setup
1. Install Go from https://golang.org/dl/
2. Install Node.js from https://nodejs.org/
3. Install pnpm: `npm install -g pnpm`

### Linux/Mac Setup
1. Install Go using your package manager or from https://golang.org/dl/
2. Install Node.js using your package manager or from https://nodejs.org/
3. Install pnpm: `npm install -g pnpm`

## Build Steps

### Full Build (Web + Go)

#### Windows
```bash
# Run the Windows build script
scripts\dev-build.bat
```

#### Linux/Mac
```bash
# Run the bash build script
./scripts/dev-build.sh
```

### Go Only Build (Without Web UI)
If you don't need the web interface, you can build just the Go binary:

```bash
go build -o fastclaw ./cmd/fastclaw
```

## Build Process Explained

1. **Web Build**: The script first builds the web interface using pnpm (or npm as fallback)
2. **Copy Web Files**: The built web files are copied to `internal/setup/web` for embedding
3. **Go Build**: The Go binary is built with the embedded web files

## Troubleshooting

### Web Build Errors
- Ensure Node.js and pnpm/npm are installed
- Check that you have internet access for dependencies
- Verify the web directory structure is intact

### Go Build Errors
- Ensure Go is installed and in your PATH
- Check that `internal/setup/web` exists and contains files
- Verify all Go dependencies are installed: `go mod tidy`

### Termux Specific Issues
The build process has been modified to handle Termux environments. The application will now gracefully handle cases where web files are not available.

## Output

The built binary will be placed in:
- Windows: `tmp\fastclaw.exe`
- Linux/Mac: `tmp/fastclaw`
