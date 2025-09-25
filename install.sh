#!/bin/bash
set -e
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
echo -e "${BLUE}Claude-Gemini MCP Integration Server Installer${NC}"
echo ""
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is required. Please install it first.${NC}"
    exit 1
fi
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Claude Code CLI not found. Please install it first:${NC}"
    echo "npm install -g @anthropic-ai/claude-code"
    exit 1
fi
echo "Downloading Claude-Gemini MCP Server..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
git clone https://github.com/i3T4AN/Claude-Gemini-MCP-Integration-Server.git
echo ""
echo "Please enter your Gemini API key:"
echo "   (Get one free at https://aistudio.google.com/apikey)"
read -p "API Key: " API_KEY
if [ -z "$API_KEY" ]; then
    echo -e "${RED}API key is required${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi
cd Claude-Gemini-MCP-Integration-Server
chmod +x setup.sh
./setup.sh "$API_KEY"
cd ~
rm -rf "$TEMP_DIR"
echo ""
echo -e "${GREEN}Installation complete!${NC}"