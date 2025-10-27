# Troubleshooting Guide

**Unified Voice-Enabled Network Management Platform**

Complete troubleshooting guide for common issues, diagnostics, and solutions.

---

## 📋 Table of Contents

- [Quick Diagnostics](#quick-diagnostics)
- [Installation Issues](#installation-issues)
- [Voice Interface Problems](#voice-interface-problems)
- [API Connection Issues](#api-connection-issues)
- [Database Problems](#database-problems)
- [Docker Deployment Issues](#docker-deployment-issues)
- [Network Utility Failures](#network-utility-failures)
- [Performance Issues](#performance-issues)
- [Memory and Storage Issues](#memory-and-storage-issues)
- [Security and Authentication](#security-and-authentication)
- [Error Code Reference](#error-code-reference)
- [Log Analysis](#log-analysis)
- [Getting Help](#getting-help)

---

## 🔍 Quick Diagnostics

### Platform Health Check

Run these commands to quickly assess platform health:

```bash
# Check platform status
curl -f http://localhost:5000/health

# Test database connection
python -c "
import sqlite3
try:
    conn = sqlite3.connect('data/network_management.db')
    print('✅ Database: OK')
    conn.close()
except Exception as e:
    print(f'❌ Database: {e}')
"

# Check MCP memory system
python -c "
import sys, os
sys.path.append('src')
try:
    from mcp.memory.manager import MCPMemoryManager
    manager = MCPMemoryManager()
    print('✅ MCP Memory: OK')
except Exception as e:
    print(f'❌ MCP Memory: {e}')
"

# Test voice interface availability
python -c "
import requests
try:
    r = requests.get('http://localhost:5000/api/v1/voice/config')
    if r.status_code == 200:
        print('✅ Voice Interface: OK')
    else:
        print(f'❌ Voice Interface: HTTP {r.status_code}')
except Exception as e:
    print(f'❌ Voice Interface: {e}')
"
```

---

## 🚀 Installation Issues

### Python Environment Problems

#### Issue: Module Not Found Errors
```
ModuleNotFoundError: No module named 'httpx'
ModuleNotFoundError: No module named 'fastapi'
```

**Solutions:**
1. **Verify virtual environment is activated**:
   ```bash
   # Check if virtual environment is active
   which python  # Should show path to .venv/bin/python
   
   # Activate if not active
   source .venv/bin/activate  # Linux/Mac
   .venv\Scripts\activate     # Windows
   ```

2. **Reinstall dependencies**:
   ```bash
   # Using uv (recommended)
   uv pip install -r requirements.txt
   
   # Or using pip
   pip install -r requirements.txt --force-reinstall
   ```

3. **Check Python version**:
   ```bash
   python --version  # Should be 3.11+
   
   # If wrong version, recreate virtual environment
   rm -rf .venv
   python3.11 -m venv .venv
   source .venv/bin/activate
   uv pip install -r requirements.txt
   ```

#### Issue: Permission Denied Errors
```
PermissionError: [Errno 13] Permission denied: '/app/data'
```

**Solutions:**
1. **Fix directory permissions**:
   ```bash
   sudo chown -R $USER:$USER data/ logs/ .claude-memory/
   chmod -R 755 data/ logs/ .claude-memory/
   ```

2. **Create directories manually**:
   ```bash
   mkdir -p data/logs backups temp
   chmod 755 data/logs backups temp
   ```

### Missing System Dependencies

#### Issue: System Package Errors
```
Error: Failed to build package dependencies
```

**Solutions:**
1. **Install system dependencies** (Ubuntu/Debian):
   ```bash
   sudo apt update
   sudo apt install -y build-essential python3-dev libssl-dev libffi-dev
   ```

2. **Install system dependencies** (RHEL/CentOS):
   ```bash
   sudo yum install -y gcc python3-devel openssl-devel libffi-devel
   ```

3. **Install system dependencies** (macOS):
   ```bash
   brew install openssl libffi
   export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
   ```

---

## 🎤 Voice Interface Problems

### Browser Compatibility Issues

#### Issue: Voice Commands Not Recognized
```
Voice interface not responding to commands
Microphone access denied
```

**Solutions:**
1. **Check browser compatibility**:
   - ✅ **Chrome 25+** (Recommended)
   - ✅ **Edge 25+** (Recommended) 
   - ⚠️ **Firefox** (Limited support)
   - ❌ **Safari** (Not supported)

2. **Enable microphone permissions**:
   ```javascript
   // Check permissions in browser console
   navigator.permissions.query({name: 'microphone'}).then(result => {
     console.log('Microphone permission:', result.state);
   });
   ```

3. **HTTPS requirement**:
   - Voice interface requires HTTPS in production
   - Use `http://localhost:5000` for development only
   - Generate SSL certificates for production:
   ```bash
   openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
   ```

#### Issue: Voice Recognition Accuracy Low
```
Commands frequently misunderstood
Wrong actions executed
```

**Solutions:**
1. **Adjust confidence threshold**:
   ```javascript
   // In browser console or voice settings
   voiceInterface.setConfidenceThreshold(0.85); // Higher = more strict
   ```

2. **Improve audio quality**:
   - Use headset microphone instead of built-in mic
   - Reduce background noise
   - Speak clearly and at normal pace
   - Ensure stable internet connection

3. **Train voice recognition**:
   ```javascript
   // Enable voice learning mode
   voiceInterface.enableLearningMode(true);
   ```

### Voice Response Issues

#### Issue: No Voice Feedback
```
Commands execute but no audio response
Voice response setting ignored
```

**Solutions:**
1. **Check audio settings**:
   ```bash
   # Test system audio (Linux)
   speaker-test -t wav -c 2
   
   # Check browser audio permissions
   # Navigate to: chrome://settings/content/sound
   ```

2. **Verify voice configuration**:
   ```javascript
   // In browser console
   speechSynthesis.getVoices().forEach(voice => {
     console.log(voice.name, voice.lang);
   });
   
   // Test speech synthesis
   speechSynthesis.speak(new SpeechSynthesisUtterance('Test message'));
   ```

3. **Browser-specific fixes**:
   ```javascript
   // Chrome: Enable experimental web features
   // Go to: chrome://flags/#enable-experimental-web-platform-features
   
   // Edge: Similar to Chrome
   // Firefox: Limited support, try latest version
   ```

---

## 🔌 API Connection Issues

### FortiManager Connection Problems

#### Issue: Connection Timeouts
```
HTTP 408: Request Timeout
Connection to FortiManager failed
```

**Solutions:**
1. **Network connectivity test**:
   ```bash
   # Test basic connectivity
   ping your-fortimanager-host
   
   # Test HTTPS port
   nc -zv your-fortimanager-host 443
   
   # Test with curl
   curl -k https://your-fortimanager-host/jsonrpc
   ```

2. **Check firewall rules**:
   ```bash
   # Allow outbound HTTPS
   sudo ufw allow out 443/tcp
   
   # Check iptables (if applicable)
   sudo iptables -L OUTPUT | grep 443
   ```

3. **Verify SSL/TLS configuration**:
   ```bash
   # Test SSL handshake
   openssl s_client -connect your-fortimanager-host:443 -servername your-fortimanager-host
   ```

#### Issue: Authentication Failures
```
HTTP 401: Unauthorized
Invalid credentials
```

**Solutions:**
1. **Verify credentials in .env**:
   ```bash
   # Check environment variables
   grep -E "FM_(HOST|USERNAME|PASSWORD)" .env
   
   # Test credentials manually
   curl -k -X POST https://your-fortimanager-host/jsonrpc \
     -H "Content-Type: application/json" \
     -d '{
       "id": 1,
       "method": "exec",
       "params": [{
         "url": "/sys/login/user",
         "data": {
           "user": "your_username",
           "passwd": "your_password"
         }
       }]
     }'
   ```

2. **Check FortiManager user permissions**:
   ```bash
   # Required permissions:
   # - Super_User profile (or custom with device management rights)
   # - API access enabled
   # - Trusted hosts configured
   ```

### API Rate Limiting

#### Issue: Too Many Requests
```
HTTP 429: Too Many Requests
Rate limit exceeded
```

**Solutions:**
1. **Check rate limits**:
   ```bash
   # View current rate limit headers
   curl -I http://localhost:5000/api/v1/devices
   ```

2. **Implement backoff strategy**:
   ```python
   import time
   import random
   
   def api_call_with_backoff(func, max_retries=3):
       for attempt in range(max_retries):
           try:
               return func()
           except RateLimitError:
               wait_time = (2 ** attempt) + random.uniform(0, 1)
               time.sleep(wait_time)
       raise Exception("Max retries exceeded")
   ```

---

## 🗄️ Database Problems

### SQLite Issues

#### Issue: Database Locked
```
sqlite3.OperationalError: database is locked
```

**Solutions:**
1. **Check for stale connections**:
   ```bash
   # Find processes using the database
   lsof data/network_management.db
   
   # Kill stale processes if needed
   sudo kill -9 <process_id>
   ```

2. **Enable WAL mode** for better concurrency:
   ```python
   import sqlite3
   conn = sqlite3.connect('data/network_management.db')
   conn.execute('PRAGMA journal_mode=WAL;')
   conn.close()
   ```

3. **Backup and recreate database**:
   ```bash
   # Backup existing data
   sqlite3 data/network_management.db .dump > backup.sql
   
   # Remove corrupted database
   rm data/network_management.db
   
   # Reinitialize
   python scripts/init_database.py
   
   # Restore data if needed
   sqlite3 data/network_management.db < backup.sql
   ```

#### Issue: Disk Space Full
```
sqlite3.OperationalError: disk I/O error
```

**Solutions:**
1. **Check disk space**:
   ```bash
   df -h
   du -sh data/
   ```

2. **Clean up logs and temporary files**:
   ```bash
   # Clean old logs (keep last 7 days)
   find data/logs/ -name "*.log" -mtime +7 -delete
   
   # Clean temporary files
   rm -rf temp/* /tmp/platform_*
   
   # Vacuum database
   sqlite3 data/network_management.db "VACUUM;"
   ```

### Database Corruption

#### Issue: Database Corruption
```
sqlite3.DatabaseError: database disk image is malformed
```

**Solutions:**
1. **Check database integrity**:
   ```bash
   sqlite3 data/network_management.db "PRAGMA integrity_check;"
   ```

2. **Attempt repair**:
   ```bash
   # Dump readable data
   sqlite3 data/network_management.db .dump > recovery.sql
   
   # Create new database
   mv data/network_management.db data/network_management.db.corrupt
   python scripts/init_database.py
   
   # Import recovered data
   sqlite3 data/network_management.db < recovery.sql
   ```

---

## 🐳 Docker Deployment Issues

### Container Startup Problems

#### Issue: Container Fails to Start
```
docker: Error response from daemon: container failed to start
```

**Solutions:**
1. **Check Docker logs**:
   ```bash
   docker logs unified-network-platform
   docker logs unified-network-platform --follow
   ```

2. **Verify image build**:
   ```bash
   # Rebuild image
   docker build -t unified-network-platform .
   
   # Check for build errors
   docker build -t unified-network-platform . --no-cache
   ```

3. **Check resource limits**:
   ```bash
   # Check Docker system info
   docker system df
   docker system prune  # Clean up if needed
   
   # Increase memory limits if needed
   docker run --memory=2g --cpus=2 unified-network-platform
   ```

#### Issue: Port Binding Conflicts
```
Error: port 5000 already in use
```

**Solutions:**
1. **Find conflicting process**:
   ```bash
   # Find process using port 5000
   sudo netstat -tlnp | grep :5000
   sudo lsof -i :5000
   
   # Kill conflicting process
   sudo kill -9 <process_id>
   ```

2. **Use different port**:
   ```bash
   # Run on different port
   docker run -p 5001:5000 unified-network-platform
   
   # Or update docker-compose.yml
   ports:
     - "5001:5000"
   ```

### Volume Mount Issues

#### Issue: Volume Permission Errors
```
PermissionError: [Errno 13] Permission denied: '/app/data'
```

**Solutions:**
1. **Fix host directory permissions**:
   ```bash
   # Create directories with correct permissions
   mkdir -p ./data ./logs ./.claude-memory
   sudo chown -R 1000:1000 ./data ./logs ./.claude-memory
   chmod -R 755 ./data ./logs ./.claude-memory
   ```

2. **Use user mapping in Docker**:
   ```yaml
   # In docker-compose.yml
   services:
     unified-platform:
       user: "${UID}:${GID}"
       environment:
         - UID=${UID}
         - GID=${GID}
   ```

3. **Run with specific user**:
   ```bash
   # Get current user ID
   id -u
   id -g
   
   # Run container with user mapping
   docker run --user $(id -u):$(id -g) unified-network-platform
   ```

---

## 🔧 Network Utility Failures

### SSL Diagnostics Issues

#### Issue: SSL Certificate Validation Failures
```
SSL certificate verify failed
SSLError: certificate has expired
```

**Solutions:**
1. **Check certificate details**:
   ```bash
   # Manual SSL check
   openssl s_client -connect example.com:443 -servername example.com
   
   # Check expiration
   echo | openssl s_client -connect example.com:443 2>/dev/null | \
     openssl x509 -noout -enddate
   ```

2. **Update CA certificates**:
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install ca-certificates
   
   # RHEL/CentOS
   sudo yum update ca-certificates
   
   # Python certificates
   pip install --upgrade certifi
   ```

3. **Handle self-signed certificates**:
   ```python
   # In utility configuration
   import ssl
   ssl_context = ssl.create_default_context()
   ssl_context.check_hostname = False
   ssl_context.verify_mode = ssl.CERT_NONE
   ```

### Device Discovery Problems

#### Issue: No Devices Found
```
Network scan completed: 0 devices found
SNMP timeout errors
```

**Solutions:**
1. **Verify network connectivity**:
   ```bash
   # Test ping to network range
   nmap -sn 192.168.1.0/24
   
   # Test specific device
   ping 192.168.1.1
   ```

2. **Check SNMP configuration**:
   ```bash
   # Test SNMP access
   snmpwalk -v2c -c public 192.168.1.1 1.3.6.1.2.1.1.1.0
   
   # Try different community strings
   snmpwalk -v2c -c private 192.168.1.1 1.3.6.1.2.1.1.1.0
   ```

3. **Firewall and security**:
   ```bash
   # Check local firewall
   sudo ufw status
   
   # Test ports
   nc -zv 192.168.1.1 161  # SNMP
   nc -zv 192.168.1.1 22   # SSH
   nc -zv 192.168.1.1 80   # HTTP
   ```

---

## ⚡ Performance Issues

### High Memory Usage

#### Issue: Memory Consumption High
```
Platform using excessive memory
Out of memory errors
```

**Solutions:**
1. **Monitor memory usage**:
   ```bash
   # Check system memory
   free -h
   htop
   
   # Check Python memory
   python -c "
   import psutil, os
   p = psutil.Process(os.getpid())
   print(f'Memory: {p.memory_info().rss / 1024 / 1024:.2f} MB')
   "
   ```

2. **Optimize database queries**:
   ```python
   # Use pagination for large results
   def get_devices_paginated(limit=100, offset=0):
       return db.query(Device).limit(limit).offset(offset).all()
   
   # Close database connections
   db.close()
   ```

3. **Configure garbage collection**:
   ```python
   import gc
   
   # Force garbage collection
   gc.collect()
   
   # Tune GC thresholds
   gc.set_threshold(700, 10, 10)
   ```

### Slow Response Times

#### Issue: API Responses Slow
```
Request timeouts
High response latency
```

**Solutions:**
1. **Enable async processing**:
   ```python
   # Use async/await for I/O operations
   import asyncio
   import httpx
   
   async def async_device_check():
       async with httpx.AsyncClient() as client:
           response = await client.get(url)
           return response.json()
   ```

2. **Add caching**:
   ```python
   from functools import lru_cache
   from datetime import datetime, timedelta
   
   @lru_cache(maxsize=100)
   def get_device_info(device_id, cache_time=300):
       # Cache expensive operations
       return device_data
   ```

3. **Database optimization**:
   ```bash
   # Add indexes for frequently queried columns
   sqlite3 data/network_management.db "
   CREATE INDEX idx_devices_brand_store ON devices(brand, store_id);
   CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);
   "
   
   # Analyze query performance
   sqlite3 data/network_management.db "
   EXPLAIN QUERY PLAN SELECT * FROM devices WHERE brand='BWW';
   "
   ```

---

## 💾 Memory and Storage Issues

### Disk Space Problems

#### Issue: Disk Space Running Low
```
No space left on device
Log files too large
```

**Solutions:**
1. **Clean up log files**:
   ```bash
   # Check log sizes
   du -sh data/logs/*
   
   # Rotate logs (keep last 10 files)
   cd data/logs
   for log in *.log; do
     tail -n 1000 "$log" > "${log}.tmp" && mv "${log}.tmp" "$log"
   done
   
   # Set up log rotation
   cat > /etc/logrotate.d/unified-platform << EOF
   /path/to/platform/data/logs/*.log {
     daily
     rotate 7
     compress
     missingok
     notifempty
   }
   EOF
   ```

2. **Clean MCP memory cache**:
   ```bash
   # Check MCP memory usage
   du -sh ~/.claude-memory/
   
   # Clean old contexts (older than 30 days)
   find ~/.claude-memory/ -type f -mtime +30 -delete
   ```

3. **Database maintenance**:
   ```bash
   # Vacuum database to reclaim space
   sqlite3 data/network_management.db "VACUUM;"
   
   # Clean old audit logs
   sqlite3 data/network_management.db "
   DELETE FROM audit_logs WHERE created_at < datetime('now', '-30 days');
   "
   ```

---

## 🔐 Security and Authentication

### Authentication Issues

#### Issue: Token Expired
```
HTTP 401: Token expired
Authentication required
```

**Solutions:**
1. **Refresh authentication token**:
   ```bash
   # Get new token
   curl -X POST http://localhost:5000/api/v1/auth/token \
     -H "Content-Type: application/json" \
     -d '{"username": "admin", "password": "password"}'
   ```

2. **Check token expiration settings**:
   ```bash
   # In .env file
   ACCESS_TOKEN_EXPIRE_MINUTES=30
   ```

3. **Implement automatic token refresh**:
   ```javascript
   // Client-side token refresh
   async function refreshToken() {
     const response = await fetch('/api/v1/auth/refresh', {
       method: 'POST',
       headers: {
         'Authorization': `Bearer ${refreshToken}`
       }
     });
     return response.json();
   }
   ```

### SSL/TLS Configuration

#### Issue: SSL Certificate Errors
```
SSL certificate verification failed
HTTPS connection errors
```

**Solutions:**
1. **Generate self-signed certificate** (development):
   ```bash
   openssl req -x509 -newkey rsa:4096 \
     -keyout config/ssl/key.pem \
     -out config/ssl/cert.pem \
     -days 365 -nodes \
     -subj "/CN=localhost"
   ```

2. **Configure SSL in application**:
   ```python
   # In main application
   if SSL_ENABLED:
       app.run(
           host='0.0.0.0',
           port=5000,
           ssl_context=(SSL_CERT_PATH, SSL_KEY_PATH)
       )
   ```

---

## 📊 Error Code Reference

### HTTP Status Codes

| Code | Description | Common Causes | Solutions |
|------|-------------|---------------|-----------|
| 400 | Bad Request | Invalid JSON, missing parameters | Check request format |
| 401 | Unauthorized | Invalid/expired token | Refresh authentication |
| 403 | Forbidden | Insufficient permissions | Check user roles |
| 404 | Not Found | Invalid endpoint, missing resource | Verify URL path |
| 429 | Too Many Requests | Rate limit exceeded | Implement backoff |
| 500 | Internal Server Error | Application error | Check logs |
| 502 | Bad Gateway | FortiManager connection error | Check network/credentials |
| 503 | Service Unavailable | System overloaded | Check resources |

### Platform-Specific Error Codes

| Code | Component | Description | Solution |
|------|-----------|-------------|----------|
| VOICE_001 | Voice Interface | Microphone permission denied | Enable browser permissions |
| VOICE_002 | Voice Interface | Speech recognition not supported | Use Chrome/Edge browser |
| VOICE_003 | Voice Interface | Command not recognized | Check command syntax |
| DB_001 | Database | Connection failed | Check database file |
| DB_002 | Database | Query timeout | Optimize query/add indexes |
| MCP_001 | Memory System | Memory path not accessible | Check permissions |
| MCP_002 | Memory System | Memory context not found | Verify context ID |
| UTIL_001 | Network Utilities | Utility execution failed | Check parameters |
| UTIL_002 | Network Utilities | Network timeout | Check connectivity |
| FM_001 | FortiManager | Authentication failed | Verify credentials |
| FM_002 | FortiManager | API call timeout | Check network/firewall |

---

## 📝 Log Analysis

### Log File Locations

```bash
# Application logs
tail -f data/logs/application.log

# Voice command logs
tail -f data/logs/voice_commands.log

# Utility execution logs
tail -f data/logs/utilities.log

# API access logs
tail -f data/logs/access.log

# Error logs
tail -f data/logs/error.log

# Docker logs
docker logs unified-network-platform --follow
```

### Common Log Patterns

#### Connection Errors
```
# FortiManager connection issues
grep "FortiManager" data/logs/error.log | tail -20

# Database connection problems
grep -i "database" data/logs/application.log | tail -10

# Network timeouts
grep -i "timeout" data/logs/*.log | tail -15
```

#### Performance Issues
```
# Slow queries
grep "slow query" data/logs/application.log

# Memory warnings
grep -i "memory" data/logs/*.log

# High CPU usage
grep -i "cpu" data/logs/application.log
```

#### Voice Interface Issues
```
# Voice recognition failures
grep "voice recognition" data/logs/voice_commands.log

# Speech synthesis errors
grep "speech synthesis" data/logs/voice_commands.log

# Browser compatibility issues
grep "browser" data/logs/voice_commands.log
```

### Log Analysis Tools

```bash
# Real-time log monitoring with colors
tail -f data/logs/application.log | grep --color=always -E "ERROR|WARNING|CRITICAL"

# Log statistics
awk '/ERROR/ {errors++} /WARNING/ {warnings++} /INFO/ {info++} END {print "Errors:", errors, "Warnings:", warnings, "Info:", info}' data/logs/application.log

# Performance metrics from logs
grep "response_time" data/logs/access.log | awk '{sum += $5; count++} END {print "Average response time:", sum/count "ms"}'
```

---

## 🆘 Getting Help

### Support Channels

1. **GitHub Issues**: 
   - Bug reports: https://github.com/kmransom56/unified-network-platform/issues
   - Feature requests: Tag with `enhancement`
   - Questions: Tag with `question`

2. **Documentation**: 
   - Full documentation: [docs/](../docs/)
   - API reference: [docs/API.md](API.md)
   - Installation guide: [docs/INSTALLATION.md](INSTALLATION.md)

3. **Community Support**:
   - GitHub Discussions
   - Stack Overflow (tag: unified-network-platform)

### Before Requesting Help

Please provide the following information:

#### System Information
```bash
# Platform information
uname -a
python --version
docker --version

# Disk space and memory
df -h
free -h

# Network configuration
ip addr show
```

#### Platform Configuration
```bash
# Environment variables (remove sensitive data)
grep -v -E "(PASSWORD|SECRET|KEY)" .env

# Platform status
curl -s http://localhost:5000/health | jq '.'

# Recent logs (last 50 lines)
tail -50 data/logs/application.log
```

#### Error Details
- **Exact error messages** with full stack traces
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Browser/client information** (for voice interface issues)
- **Network environment** (for connectivity issues)

### Emergency Support

For **critical production issues**:

1. **Check platform health**: `curl http://localhost:5000/health`
2. **Review recent logs**: `tail -100 data/logs/error.log`
3. **Restart services**: `docker-compose restart` or `systemctl restart unified-platform`
4. **Create emergency ticket** with full system information

### Self-Service Resources

- **Platform Status Dashboard**: http://localhost:5000/health
- **API Testing Interface**: http://localhost:5000/api/docs  
- **Voice Command Help**: Say "Help" or "What can you do?"
- **Utility Documentation**: Built-in help for each utility
- **Database Browser**: Use SQLite browser for data inspection

---

## ⚡ Quick Fixes Summary

### Most Common Issues (90%+ of problems)

1. **Voice not working**: Use Chrome/Edge, enable microphone permissions, ensure HTTPS
2. **Module not found**: Activate virtual environment, reinstall requirements  
3. **Database locked**: Kill stale processes, restart platform
4. **FortiManager timeout**: Check network connectivity, verify credentials
5. **Port already in use**: Find and kill conflicting process, use different port
6. **Permission denied**: Fix directory permissions, run as correct user
7. **Memory errors**: Clean logs, restart services, check disk space
8. **SSL errors**: Update certificates, check system time

### One-Line Fixes

```bash
# Restart everything
docker-compose down && docker-compose up -d

# Clear all locks and restart
rm -f .git/*.lock && rm -f data/*.db-journal && python src/main.py

# Full cleanup and restart
docker system prune -f && docker-compose build --no-cache && docker-compose up -d

# Reset voice interface
# Go to browser settings > Site settings > Clear data for localhost:5000

# Quick database reset
rm data/*.db && python scripts/init_database.py
```

---

**Need immediate help?** Start with the [Quick Diagnostics](#quick-diagnostics) section and work through the relevant troubleshooting steps for your specific issue.

**Still stuck?** Create a GitHub issue with your system information, error logs, and steps you've already tried. The more details you provide, the faster we can help! 🚀