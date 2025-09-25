# Claude-Gemini MCP Integration Server

> Enable direct collaboration between Claude Code and Google's Gemini AI models through the Model Context Protocol (MCP)

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![MCP Compatible](https://img.shields.io/badge/MCP-2024--11--05-green.svg)](https://modelcontextprotocol.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

The Claude-Gemini MCP Integration Server bridges Claude Code and Google's Gemini AI models, enabling seamless AI-to-AI collaboration within your development workflow. Ask Gemini questions, get code reviews, and brainstorm solutions directly from Claude Code.

### Key Features

- **Direct AI Collaboration**: Claude can consult Gemini for different perspectives
- **Smart Code Reviews**: Get Gemini's analysis on security, performance, and best practices
- **Creative Brainstorming**: Leverage Gemini's creativity for problem-solving
- **One-Command Setup**: Complete installation in under 2 minutes
- **Easy Integration**: Works seamlessly with Claude Code CLI

## Quick Start

### Prerequisites

- **Python 3.8+** - [Download here](https://www.python.org/downloads/)
- **Claude Code CLI** - Install with: `npm install -g @anthropic-ai/claude-code`
- **Gemini API Key** - Get free at [Google AI Studio](https://aistudio.google.com/apikey)

### Installation

#### Option 1: Automated Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/i3T4AN/Claude-Gemini-MCP-Integration-Server/main/install.sh | bash
```

#### Option 2: Manual Setup
```bash
# Clone the repository
git clone https://github.com/i3T4AN/Claude-Gemini-MCP-Integration-Server.git
cd Claude-Gemini-MCP-Integration-Server

# Run setup with your API key
chmod +x setup.sh
./setup.sh YOUR_GEMINI_API_KEY
```

## Usage

### Starting Claude Code
```bash
claude
```

### Accessing Tools
In Claude Code, use the `/mcp` command to access MCP tools:
```
/mcp
```

### Available Tools

#### 1. `ask_gemini` - Direct Questions
Ask Gemini anything and get the response in Claude's context:
```
mcp__claude-gemini-integration__ask_gemini
```

**Example prompts:**
- "What are the latest Python best practices for async programming?"
- "Explain quantum computing in simple terms"
- "Compare React vs Vue for a new project"

#### 2. `gemini_code_review` - Code Analysis
Get comprehensive code reviews focusing on specific areas:
```
mcp__claude-gemini-integration__gemini_code_review
```

**Focus areas:**
- `general` - Overall code quality and best practices
- `security` - Security vulnerabilities and concerns  
- `performance` - Optimization opportunities
- `maintainability` - Code clarity and structure

#### 3. `gemini_brainstorm` - Creative Solutions
Brainstorm ideas and solutions with additional context:
```
mcp__claude-gemini-integration__gemini_brainstorm
```

**Example topics:**
- "Mobile app architecture for a social platform"
- "Database design for high-traffic e-commerce"
- "Marketing strategies for developer tools"

## Configuration

### API Key Management

The setup script automatically configures your API key. If you need to change it:

1. **Environment Variable** (Recommended):
   ```bash
   export GEMINI_API_KEY="your-new-api-key"
   ```

2. **Direct Edit**:
   ```bash
   nano ~/.claude-mcp-servers/claude-gemini-integration/server.py
   # Update the API_KEY variable
   ```

### Advanced Configuration

#### Temperature Control
Adjust response creativity in `ask_gemini`:
- `0.0` - Focused, deterministic responses
- `0.5` - Balanced (default)
- `1.0` - Creative, varied responses

#### Model Selection
The server uses `gemini-2.0-flash` by default. To use different models, edit `server.py`:
```python
model = genai.GenerativeModel('gemini-1.5-pro')  # For more powerful responses
```

## Architecture

### System Components

```
┌─────────────────┐    ┌──────────────────────┐    ┌─────────────────┐
│   Claude Code   │◄──►│  MCP Integration     │◄──►│   Gemini API    │
│      CLI        │    │      Server          │    │                 │
└─────────────────┘    └──────────────────────┘    └─────────────────┘
```

### Protocol Details
- **Protocol**: JSON-RPC 2.0 over stdin/stdout
- **MCP Version**: 2024-11-05
- **Transport**: Standard MCP server communication

## API Limits & Costs

### Gemini Free Tier
- **Rate Limit**: 15 RPM (requests per minute)
- **Daily Limit**: 1,500 requests per day
- **Token Limit**: 32,000 tokens per minute
