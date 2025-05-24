#!/bin/bash

# Health Check Script for OmniSum Development Environment
# This script validates that all required tools and services are properly configured

echo "🔍 OmniSum Environment Health Check"
echo "==================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check command availability
check_command() {
    local cmd=$1
    local name=$2
    if command -v $cmd &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n 1)
        echo -e "${GREEN}✓${NC} $name: $version"
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not found"
        return 1
    fi
}

# Function to check service health
check_service() {
    local url=$1
    local name=$2
    if curl -f -s $url > /dev/null; then
        echo -e "${GREEN}✓${NC} $name: Running"
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not responding"
        return 1
    fi
}

# Check Node.js environment
echo "📦 Checking Node.js Environment:"
check_command "node" "Node.js"
check_command "pnpm" "pnpm"
check_command "npm" "npm"
check_command "tsc" "TypeScript"
echo ""

# Check development tools
echo "🛠️  Checking Development Tools:"
check_command "git" "Git"
check_command "docker" "Docker"
check_command "gh" "GitHub CLI"
echo ""

# Check project setup
echo "📁 Checking Project Setup:"
if [ -f "package.json" ]; then
    echo -e "${GREEN}✓${NC} package.json exists"
else
    echo -e "${RED}✗${NC} package.json not found"
fi

if [ -f "tsconfig.json" ]; then
    echo -e "${GREEN}✓${NC} tsconfig.json exists"
else
    echo -e "${RED}✗${NC} tsconfig.json not found"
fi

if [ -d "node_modules" ]; then
    echo -e "${GREEN}✓${NC} Dependencies installed"
else
    echo -e "${YELLOW}!${NC} Dependencies not installed (run: pnpm install)"
fi
echo ""

# Check services (if running)
echo "🌐 Checking Services:"
check_service "http://localhost:3000/health" "Backend API (port 3000)"
check_service "http://localhost:5173" "Vite Dev Server (port 5173)"
check_service "http://localhost:8080" "Frontend Server (port 8080)"
echo ""

# Check Gitpod/DevContainer specific
echo "🐳 Checking Container Environment:"
if [ -n "$GITPOD_WORKSPACE_ID" ]; then
    echo -e "${GREEN}✓${NC} Running in Gitpod"
    echo "  Workspace ID: $GITPOD_WORKSPACE_ID"
elif [ -f "/.dockerenv" ]; then
    echo -e "${GREEN}✓${NC} Running in Docker container"
else
    echo -e "${YELLOW}!${NC} Not running in container environment"
fi
echo ""

# Summary
echo "==================================="
echo "Health check complete!"
echo ""
echo "To start development:"
echo "  1. Install dependencies: pnpm install"
echo "  2. Start backend: pnpm run dev:server"
echo "  3. Run tests: pnpm test"
echo ""