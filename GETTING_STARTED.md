# Getting Started

This repository contains the complete Unified Voice-Enabled Network Management Platform for Restaurant Chain Operations.

## Repository Status

🚀 **Repository Created Successfully!**

The unified platform has been created with:

- ✅ Complete source code migration from network-device-mcp-server
- ✅ Enhanced utilities integration (30+ network tools)
- ✅ Voice command system with 61 voice commands
- ✅ MCP memory system for autonomous operations
- ✅ 8 Claude Code skills for multi-hour execution
- ✅ Comprehensive documentation suite
- ✅ Docker deployment configuration

## Quick Start

1. **Clone this repository**:
   ```bash
   git clone https://github.com/kmransom56/unified-network-platform.git
   cd unified-network-platform
   ```

2. **Set up environment**:
   ```bash
   cp .env.example .env
   # Edit .env with your FortiManager credentials
   ```

3. **Install dependencies**:
   ```bash
   uv venv
   source .venv/bin/activate  # Linux/Mac
   uv pip install -r requirements.txt
   ```

4. **Initialize database**:
   ```bash
   python scripts/init_database.py
   ```

5. **Start the platform**:
   ```bash
   python src/rest_api_server.py
   ```

6. **Access the interface**:
   - Open http://localhost:5000
   - Enable voice commands via microphone icon
   - Try: "Hello platform" or "Show device status"

## Docker Deployment

```bash
docker-compose up -d
```

## Documentation

- 📖 [Full Documentation](docs/) - Complete guides and references
- 🎤 [Voice Commands](docs/VOICE_COMMANDS.md) - 100+ voice commands
- 🔧 [API Reference](docs/API.md) - Complete REST API documentation
- 🧠 [Skills Guide](docs/SKILLS.md) - 8 autonomous Claude Code skills
- 🚀 [Installation Guide](docs/INSTALLATION.md) - Detailed setup instructions

## Key Features

### Voice-Enabled Operations
- Natural language network management
- Multi-brand support (BWW, Arby's, Sonic)
- 61 intelligent voice commands
- Real-time speech feedback

### Enhanced Network Utilities
- 22 network diagnostic tools
- SSL/TLS certificate analysis
- Device discovery and inventory
- Performance monitoring
- Security assessments

### Autonomous Intelligence
- 8 specialized Claude Code skills
- Multi-hour autonomous execution
- MCP memory persistence
- Automatic error recovery
- Progress tracking and resumption

### Restaurant Chain Support
- Multi-brand network management
- Store-specific operations
- POS system monitoring
- Security compliance
- Performance analytics

## Support

For questions and support:
- 📧 Contact: network-team@company.com
- 📚 Documentation: [docs/](docs/)
- 🐛 Issues: Use GitHub Issues for bug reports

---

**Welcome to the future of voice-enabled network management!** 🎉