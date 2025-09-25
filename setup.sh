#!/bin/bash
set -e
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
echo -e "${BLUE}Claude-Gemini MCP Integration Server Setup${NC}"
echo ""
# Check if API key was provided
API_KEY="$1"
if [ -z "$API_KEY" ]; then
    echo -e "${RED}Please provide your Gemini API key${NC}"
    echo "Usage: ./setup.sh YOUR_GEMINI_API_KEY"
    echo ""
    echo "Get a free API key at: https://aistudio.google.com/apikey"
    exit 1
fi
# Check Python version
echo "Checking requirements..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is required but not installed.${NC}"
    exit 1
fi
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "Python $PYTHON_VERSION found"
# Check Claude Code
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Claude Code CLI not found. Please install it first:${NC}"
    echo "npm install -g @anthropic-ai/claude-code"
    exit 1
fi
echo "Claude Code CLI found"
# Create directory
echo ""
echo "Creating MCP server directory..."
mkdir -p ~/.claude-mcp-servers/claude-gemini-integration
# Copy server file
echo "Installing server..."
cp server.py ~/.claude-mcp-servers/claude-gemini-integration/
# Replace API key in server
sed -i.bak "s/YOUR_API_KEY_HERE/$API_KEY/g" ~/.claude-mcp-servers/claude-gemini-integration/server.py
rm ~/.claude-mcp-servers/claude-gemini-integration/server.py.bak
# Install Python dependencies
echo ""
echo "Installing Python dependencies..."
pip3 install google-generativeai --quiet
# Remove any existing MCP configuration
echo ""
echo "Configuring Claude Code..."
claude mcp remove claude-gemini-integration 2>/dev/null || true
# Add MCP server with global scope
claude mcp add --scope user claude-gemini-integration python3 ~/.claude-mcp-servers/claude-gemini-integration/server.py
echo -e "\n${GREEN}Setup complete!${NC}\n\nUsage:\n  claude\n  /mcp\n  mcp__claude-gemini-integration__ask_gemini\n\nTools: ask_gemini, code_review, brainstorm"
