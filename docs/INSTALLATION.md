# Installation Guide

**Unified Voice-Enabled Network Management Platform**

This guide provides step-by-step instructions for installing and configuring the platform in various environments.

---

## 📋 Prerequisites

### System Requirements
- **Operating System**: Linux, macOS, or Windows 10/11
- **Python**: 3.11 or higher
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Storage**: 2GB free space minimum
- **Network**: Internet connection for dependencies and FortiManager access

### Required Software
- **Python 3.11+** with pip
- **uv** (Python package installer) - Recommended
- **Git** for version control
- **Modern web browser** with Web Speech API support
- **Docker** (optional, for containerized deployment)

### Network Access Requirements
- **FortiManager**: Port 443 (HTTPS)
- **FortiAnalyzer**: Port 443 (HTTPS) - Optional
- **Meraki Dashboard**: Port 443 (HTTPS) - Optional
- **Internet Access**: For package downloads and updates

---

## 🚀 Quick Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-org/unified-network-platform.git
cd unified-network-platform
```

### 2. Set Up Python Environment
```bash
# Using uv (recommended)
uv venv
source .venv/bin/activate  # Linux/Mac
.venv\\Scripts\\activate    # Windows

# Or using standard venv
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\\Scripts\\activate    # Windows
```

### 3. Install Dependencies
```bash
# Using uv (faster)
uv pip install -r requirements.txt

# Or using pip
pip install -r requirements.txt
```

### 4. Configure Environment
```bash
cp .env.example .env
# Edit .env with your configuration (see Configuration section)
```

### 5. Initialize Databases
```bash
python scripts/init_database.py
```

### 6. Start the Platform
```bash
python src/rest_api_server.py
```

### 7. Access the Platform
Open your web browser and navigate to:
- **Main Dashboard**: http://localhost:5000
- **Voice Interface**: Click the microphone icon to enable voice commands

---

## 🐳 Docker Installation

### Prerequisites
- Docker 20.10+
- Docker Compose 2.0+

### 1. Quick Start with Docker Compose
```bash
# Clone repository
git clone https://github.com/your-org/unified-network-platform.git
cd unified-network-platform

# Copy and configure environment
cp .env.example .env
# Edit .env with your settings

# Start all services
docker-compose up -d

# View logs
docker-compose logs -f unified-platform
```

### 2. Production Docker Deployment
```bash
# Build production image
docker build -t unified-network-platform:latest .

# Run with production configuration
docker run -d \\
  --name unified-platform \\
  -p 5000:5000 \\
  -v ./config:/app/config:ro \\
  -v platform_data:/app/data \\
  -v claude_memory:/app/.claude-memory \\
  --env-file .env \\
  unified-network-platform:latest
```

### 3. Docker Services Overview
```bash
# Core platform services
docker-compose up unified-platform redis

# With PostgreSQL database
docker-compose --profile with-postgres up

# With monitoring (Prometheus/Grafana)
docker-compose --profile with-monitoring up

# With log aggregation (ELK Stack)
docker-compose --profile with-logging up

# Full stack
docker-compose --profile with-postgres --profile with-monitoring up
```

---

## ⚙️ Detailed Configuration

### 1. Environment Configuration

Edit the `.env` file with your specific settings:

```bash
# Core Application Settings
APP_MODE=production
DEBUG=false
API_HOST=0.0.0.0
API_PORT=5000

# FortiManager Configuration (Required)
FM_HOST=your-fortimanager-host.company.com
FM_USERNAME=your_username
FM_PASSWORD=your_secure_password

# Database Configuration
DATABASE_URL=sqlite:///./data/network_management.db
# For PostgreSQL: DATABASE_URL=postgresql://user:password@localhost/network_management

# Voice Interface
VOICE_ENABLED=true
VOICE_RATE=1.0
VOICE_VOLUME=0.8

# Brand Configuration
BRANDS_ENABLED=BWW,ARBYS,SONIC
BWW_PREFIX=IBR-BWW
ARBYS_PREFIX=IBR-ARBYS
SONIC_PREFIX=IBR-SONIC
```

### 2. FortiManager Integration Setup

#### Create Service Account
1. Log into your FortiManager
2. Navigate to **System Settings > Admin > Administrators**
3. Create new administrator with:
   - **Username**: `network-platform-api`
   - **Profile**: `Super_User` (or custom profile with required permissions)
   - **Password**: Strong password
   - **Trusted Hosts**: Platform server IP(s)

#### Required Permissions
```
- Device Manager: Read/Write
- Policy & Objects: Read/Write  
- FortiAnalyzer: Read (if using FortiAnalyzer features)
- System Settings: Read
- Log & Report: Read
```

#### Test Connection
```bash
python -c "
import os
os.environ['FM_HOST'] = 'your-fortimanager-host'
os.environ['FM_USERNAME'] = 'your_username' 
os.environ['FM_PASSWORD'] = 'your_password'

import sys
sys.path.append('src')
from platforms.fortimanager import FortiManagerClient

client = FortiManagerClient()
result = client.test_connection()
print('Connection test:', 'PASSED' if result else 'FAILED')
"
```

### 3. Voice Interface Setup

#### Browser Requirements
- **Chrome/Edge**: Full support (recommended)
- **Firefox**: Partial support
- **Safari**: Limited support

#### Enable Voice Features
1. Open the platform in your browser
2. Navigate to **Settings** → **Voice Configuration**
3. Click **Enable Voice Commands**
4. Allow microphone access when prompted
5. Test with: *"Hello platform, show overview"*

#### Voice Settings
- **Speech Rate**: 0.5x to 2.0x (1.0x default)
- **Volume**: 0.0 to 1.0 (0.8 default)
- **Continuous Listening**: Enable for hands-free operation
- **Accessibility Mode**: For screen reader compatibility

### 4. Network Utilities Configuration

#### Default Network Range
```bash
# Set your default network for device discovery
DEFAULT_NETWORK_RANGE=192.168.1.0/24

# SNMP Configuration
SNMP_COMMUNITY=public
SNMP_TIMEOUT=60

# SSL Diagnostics
SSL_VERIFY_CHAIN=true
SSL_CHECK_EXPIRATION=true
SSL_WARNING_DAYS=30
```

#### Utility Paths
Utilities are automatically discovered from:
- `src/utilities/scripts/` (30+ network tools)
- Custom utilities can be added to this directory

---

## 🔧 Advanced Installation Options

### 1. Development Installation

For development and customization:

```bash
# Clone with development extras
git clone https://github.com/your-org/unified-network-platform.git
cd unified-network-platform

# Install with development dependencies
uv pip install -e ".[dev]"

# Install pre-commit hooks
pre-commit install

# Run in development mode
python src/rest_api_server.py --debug
```

### 2. Production Installation with Systemd

#### Create System User
```bash
sudo useradd --system --create-home --shell /bin/bash platform
sudo usermod -aG audio platform  # For voice features
```

#### Install Platform
```bash
sudo -u platform git clone https://github.com/your-org/unified-network-platform.git /opt/unified-platform
cd /opt/unified-platform

sudo -u platform python -m venv .venv
sudo -u platform .venv/bin/pip install -r requirements.txt
```

#### Create Systemd Service
```bash
sudo cp deploy/systemd/unified-platform.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable unified-platform
sudo systemctl start unified-platform
```

#### Service Management
```bash
# Check status
sudo systemctl status unified-platform

# View logs
sudo journalctl -u unified-platform -f

# Restart service
sudo systemctl restart unified-platform
```

### 3. High Availability Installation

#### Load Balancer Configuration (Nginx)
```bash
# Install Nginx
sudo apt install nginx

# Copy configuration
sudo cp config/nginx/unified-platform.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/unified-platform.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### Multiple Platform Instances
```bash
# Instance 1
API_PORT=5000 python src/rest_api_server.py &

# Instance 2  
API_PORT=5001 python src/rest_api_server.py &

# Instance 3
API_PORT=5002 python src/rest_api_server.py &
```

#### Database Clustering (PostgreSQL)
```sql
-- Create replication user
CREATE USER platform_replicator REPLICATION LOGIN ENCRYPTED PASSWORD 'secure_password';

-- Configure streaming replication
-- See docs/DATABASE_CLUSTERING.md for detailed setup
```

---

## 🧪 Testing Installation

### 1. Basic Functionality Test
```bash
# Test database connectivity
python -c "
import sqlite3
conn = sqlite3.connect('data/network_management.db')
print('✅ Database connection OK')
conn.close()
"

# Test platform startup
timeout 30 python src/rest_api_server.py --test-mode
```

### 2. API Endpoints Test
```bash
# Health check
curl -f http://localhost:5000/health

# Platform information
curl -f http://localhost:5000/api/info

# Available utilities
curl -f http://localhost:5000/api/utilities/available
```

### 3. Voice Interface Test
1. Open http://localhost:5000
2. Click the microphone icon
3. Say: *"Show platform status"*
4. Verify voice response and UI updates

### 4. Network Utilities Test
```bash
# Test device discovery utility
curl -X POST http://localhost:5000/api/utilities/device-discovery \\
  -H "Content-Type: application/json" \\
  -d '{"network": "192.168.1.0/24"}'

# Test SSL diagnostics
curl -X POST http://localhost:5000/api/utilities/ssl-diagnostics \\
  -H "Content-Type: application/json" \\
  -d '{"host": "google.com", "port": 443}'
```

### 5. Integration Test Suite
```bash
# Run comprehensive test suite
python tests/test_utilities_integration.py

# Run specific test categories
python -m pytest tests/unit/
python -m pytest tests/integration/
python -m pytest tests/api/
```

---

## 🔐 Security Configuration

### 1. SSL/HTTPS Setup
```bash
# Generate self-signed certificates (development)
mkdir -p config/ssl
openssl req -x509 -newkey rsa:4096 -keyout config/ssl/key.pem -out config/ssl/cert.pem -days 365 -nodes

# Configure HTTPS in .env
SSL_ENABLED=true
SSL_CERT_PATH=./config/ssl/cert.pem
SSL_KEY_PATH=./config/ssl/key.pem
```

### 2. Authentication Setup
```bash
# Generate secret key
python -c "
import secrets
print(f'SECRET_KEY={secrets.token_urlsafe(32)}')
" >> .env

# Set token expiration
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

### 3. Firewall Configuration
```bash
# Allow platform ports
sudo ufw allow 5000/tcp  # Platform
sudo ufw allow 9090/tcp  # Metrics (optional)

# FortiManager access (outbound)
sudo ufw allow out 443/tcp
```

---

## 🚨 Troubleshooting

### Common Issues

#### 1. Import Errors
```bash
# Error: ModuleNotFoundError
# Solution: Ensure Python path is set correctly
export PYTHONPATH=/path/to/unified-platform/src:$PYTHONPATH
```

#### 2. Voice Interface Not Working
- Check browser compatibility (Chrome/Edge recommended)
- Ensure microphone permissions are granted
- Verify HTTPS is enabled (required for Speech API)
- Check browser console for JavaScript errors

#### 3. Database Connection Issues
```bash
# Check database file permissions
ls -la data/network_management.db

# Recreate database
rm data/*.db
python scripts/init_database.py
```

#### 4. FortiManager Connection Failures
- Verify network connectivity: `ping your-fortimanager-host`
- Check credentials and permissions
- Verify SSL certificate trust
- Review FortiManager logs

#### 5. Utility Execution Failures
- Check utility script permissions
- Verify required dependencies are installed
- Review utility-specific logs in `data/logs/utilities.log`

### Log Analysis
```bash
# Platform logs
tail -f data/logs/application.log

# Voice command logs
tail -f data/logs/voice_commands.log

# Utility execution logs
tail -f data/logs/utilities.log

# Docker logs
docker logs unified-network-platform -f
```

### Performance Issues
```bash
# Check system resources
htop
df -h
free -m

# Monitor platform performance
curl http://localhost:9090/metrics
```

---

## 📞 Getting Help

### Resources
- **Documentation**: [docs/](./docs/)
- **API Reference**: [docs/API.md](./API.md)
- **Voice Commands**: [docs/VOICE_COMMANDS.md](./VOICE_COMMANDS.md)
- **Troubleshooting**: [docs/TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

### Support Channels
- **GitHub Issues**: Report bugs and request features
- **GitHub Discussions**: Community support and questions
- **Email**: network-team@company.com

### Logs for Support
When requesting support, include:
```bash
# System information
uname -a
python --version
pip list | grep -E "(fastapi|uvicorn|flask)"

# Platform logs (last 100 lines)
tail -n 100 data/logs/application.log

# Configuration (remove sensitive data)
grep -v -E "(PASSWORD|SECRET|KEY)" .env
```

---

**Installation complete!** 🎉

Your Unified Voice-Enabled Network Management Platform is now ready for use. Navigate to http://localhost:5000 to access the professional NOC interface and start managing your restaurant network infrastructure with voice commands!