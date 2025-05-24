#!/bin/bash

# Environment Validation Script
# Validates the build environment and supervisor status

echo "🚀 Environment Validation"
echo "========================"
echo ""

# Build Info (if available from supervisor)
echo "📊 Build Information:"
echo "  Supervisor Version: ${BUILD_VERSION:-Not available}"
echo "  Commit Hash: ${BUILD_COMMIT:-Not available}"
echo "  Build Time: ${BUILD_TIME:-Not available}"
echo ""

# System Info
echo "💻 System Information:"
echo "  OS: $(uname -s)"
echo "  Architecture: $(uname -m)"
echo "  Hostname: $(hostname)"
echo ""

# Container/Gitpod Detection
echo "🐳 Environment Type:"
if [ -n "$GITPOD_WORKSPACE_ID" ]; then
    echo "  ✓ Gitpod Workspace Detected"
    echo "    - Workspace ID: $GITPOD_WORKSPACE_ID"
    echo "    - Workspace URL: $GITPOD_WORKSPACE_URL"
    
    # Check Gitpod automations
    if command -v gitpod &> /dev/null; then
        echo ""
        echo "📋 Gitpod Automations Status:"
        gitpod automations list 2>/dev/null || echo "  Unable to list automations"
    fi
elif [ -f "/.dockerenv" ]; then
    echo "  ✓ Docker Container Detected"
    if [ -f "/.devcontainer/devcontainer.json" ]; then
        echo "    - Dev Container configuration found"
    fi
else
    echo "  ⚠️  Local Environment (not containerized)"
fi
echo ""

# Process Check
echo "🔄 Running Processes:"
if pgrep -f "node" > /dev/null; then
    echo "  ✓ Node.js processes running"
    pgrep -af "node" | grep -E "(server|backend)" | head -5 | sed 's/^/    - /'
else
    echo "  ✗ No Node.js processes found"
fi
echo ""

# Port Check
echo "🌐 Port Status:"
for port in 3000 5173 8080; do
    if lsof -i :$port > /dev/null 2>&1 || netstat -tuln 2>/dev/null | grep -q ":$port "; then
        echo "  ✓ Port $port is in use"
    else
        echo "  ✗ Port $port is available"
    fi
done
echo ""

# Quick API test
echo "🔌 API Connectivity:"
if curl -s -f http://localhost:3000/health > /dev/null 2>&1; then
    response=$(curl -s http://localhost:3000/health)
    echo "  ✓ Backend API is responding"
    echo "    Response: $response"
else
    echo "  ✗ Backend API is not responding"
    echo "    Try: pnpm run dev:server"
fi
echo ""

echo "========================"
echo "Validation complete!"