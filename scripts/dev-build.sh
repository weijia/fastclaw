#!/bin/bash
set -e

# Build web
cd web
if command -v pnpm &> /dev/null; then
    pnpm build
elif command -v npm &> /dev/null; then
    npm run build
else
    echo "Error: Neither pnpm nor npm found. Please install Node.js and pnpm."
    exit 1
fi
cd ..

# Create tmp directory if it doesn't exist
mkdir -p tmp

# Copy web output to embed dir
if [ -d "web/out" ]; then
    rm -rf internal/setup/web
    cp -r web/out internal/setup/web
    echo "Web files copied to internal/setup/web"
else
    echo "Error: web/out directory not found. Web build may have failed."
    exit 1
fi

# Build Go binary
if command -v go &> /dev/null; then
    go build -ldflags "-X main.version=dev" -o tmp/fastclaw ./cmd/fastclaw
    echo "Go binary built successfully"
else
    echo "Error: go command not found. Please install Go."
    exit 1
fi
