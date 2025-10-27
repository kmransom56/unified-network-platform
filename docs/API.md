# API Reference

**Unified Voice-Enabled Network Management Platform**

Complete API documentation for all endpoints, authentication, and integration patterns.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Authentication](#authentication)
- [Core Endpoints](#core-endpoints)
- [Device Management](#device-management)
- [Network Utilities](#network-utilities)
- [Voice Interface](#voice-interface)
- [Investigation System](#investigation-system)
- [MCP Memory System](#mcp-memory-system)
- [Error Handling](#error-handling)
- [Rate Limiting](#rate-limiting)
- [WebSocket Events](#websocket-events)
- [SDK Examples](#sdk-examples)

---

## 🔍 Overview

The platform provides a comprehensive REST API with WebSocket support for real-time updates. All endpoints follow RESTful conventions and return JSON responses.

### Base URL
- **Development**: `http://localhost:5000`
- **Production**: `https://your-domain.com`

### API Version
- **Current Version**: `v1`
- **Versioning**: URL-based (`/api/v1/...`)

### Content Type
- **Request**: `application/json`
- **Response**: `application/json`

---

## 🔐 Authentication

### Authentication Methods

#### 1. Bearer Token Authentication (Recommended)
```http
Authorization: Bearer <access_token>
```

#### 2. API Key Authentication
```http
X-API-Key: <api_key>
```

### Obtaining Access Tokens

**POST** `/api/v1/auth/token`

```json
{
  "username": "your_username",
  "password": "your_password"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "expires_in": 3600,
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Refreshing Tokens

**POST** `/api/v1/auth/refresh`

```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## 🌐 Core Endpoints

### Health Check

**GET** `/health`

Returns platform health status and system information.

```http
GET /health
```

**Response:**
```json
{
  "status": "healthy",
  "version": "2.0.0",
  "timestamp": "2025-10-27T12:00:00Z",
  "services": {
    "database": "healthy",
    "mcp_memory": "healthy",
    "fortimanager": "connected",
    "enhanced_utilities": "available"
  },
  "system": {
    "cpu_usage": 15.2,
    "memory_usage": 45.8,
    "disk_usage": 23.1
  }
}
```

### Platform Information

**GET** `/api/v1/info`

Returns detailed platform information and capabilities.

```http
GET /api/v1/info
```

**Response:**
```json
{
  "platform": {
    "name": "Unified Voice-Enabled Network Management Platform",
    "version": "2.0.0",
    "build": "2025.10.27.1200"
  },
  "features": {
    "voice_commands": true,
    "enhanced_utilities": true,
    "ltm_intelligence": true,
    "multi_brand_support": true
  },
  "supported_brands": ["BWW", "ARBYS", "SONIC"],
  "utility_count": 22,
  "active_sessions": 5
}
```

---

## 🖥️ Device Management

### List Devices

**GET** `/api/v1/devices`

Query parameters:
- `brand` (optional): Filter by brand (BWW, ARBYS, SONIC)
- `store_id` (optional): Filter by store ID
- `status` (optional): Filter by status (online, offline, warning, critical)
- `limit` (optional): Number of results (default: 100)
- `offset` (optional): Pagination offset (default: 0)

```http
GET /api/v1/devices?brand=BWW&status=online&limit=50
```

**Response:**
```json
{
  "devices": [
    {
      "id": 123,
      "name": "IBR-BWW-1001-FW01",
      "ip_address": "10.1.1.1",
      "device_type": "firewall",
      "brand": "BWW",
      "store_id": "1001",
      "model": "FortiGate 60F",
      "firmware_version": "7.2.0",
      "status": "online",
      "last_seen": "2025-10-27T11:55:00Z",
      "configuration": {
        "interfaces": 8,
        "vpn_tunnels": 2,
        "policies": 45
      }
    }
  ],
  "total": 150,
  "limit": 50,
  "offset": 0,
  "has_more": true
}
```

### Get Device Details

**GET** `/api/v1/devices/{device_id}`

```http
GET /api/v1/devices/123
```

**Response:**
```json
{
  "id": 123,
  "name": "IBR-BWW-1001-FW01",
  "ip_address": "10.1.1.1",
  "device_type": "firewall",
  "brand": "BWW",
  "store_id": "1001",
  "model": "FortiGate 60F",
  "firmware_version": "7.2.0",
  "status": "online",
  "last_seen": "2025-10-27T11:55:00Z",
  "detailed_info": {
    "serial_number": "FG60F-3G1234567890",
    "uptime": "45 days, 12:34:56",
    "cpu_usage": 15.2,
    "memory_usage": 45.8,
    "session_count": 1250,
    "throughput": "125 Mbps"
  },
  "interfaces": [
    {
      "name": "port1",
      "ip": "10.1.1.1/24",
      "status": "up",
      "speed": "1000"
    }
  ],
  "recent_events": [
    {
      "timestamp": "2025-10-27T11:50:00Z",
      "level": "info",
      "message": "VPN tunnel to HQ established"
    }
  ]
}
```

### Update Device

**PUT** `/api/v1/devices/{device_id}`

```json
{
  "name": "IBR-BWW-1001-FW01-NEW",
  "status": "maintenance",
  "configuration": {
    "maintenance_mode": true,
    "maintenance_reason": "Firmware upgrade scheduled"
  }
}
```

---

## 🔧 Network Utilities

### List Available Utilities

**GET** `/api/v1/utilities/available`

```http
GET /api/v1/utilities/available
```

**Response:**
```json
{
  "utilities": [
    {
      "name": "device_discovery",
      "description": "Enhanced network device discovery with multi-protocol support",
      "voice_commands": ["discover devices", "scan network", "find devices"],
      "category": "discovery",
      "parameters": [
        {
          "name": "network",
          "type": "string",
          "required": true,
          "description": "Network range to scan (e.g., 192.168.1.0/24)"
        },
        {
          "name": "timeout",
          "type": "integer",
          "required": false,
          "default": 60,
          "description": "Scan timeout in seconds"
        },
        {
          "name": "protocols",
          "type": "array",
          "required": false,
          "default": ["ping", "snmp"],
          "description": "Discovery protocols to use"
        }
      ],
      "endpoint": "/api/v1/utilities/device-discovery"
    },
    {
      "name": "ssl_diagnostics",
      "description": "Comprehensive SSL/TLS certificate analysis and validation",
      "voice_commands": ["check ssl", "ssl diagnostics", "validate certificate"],
      "category": "security",
      "parameters": [
        {
          "name": "host",
          "type": "string",
          "required": true,
          "description": "Target hostname or IP address"
        },
        {
          "name": "port",
          "type": "integer",
          "required": false,
          "default": 443,
          "description": "Target port number"
        }
      ],
      "endpoint": "/api/v1/utilities/ssl-diagnostics"
    }
  ],
  "total_count": 22,
  "categories": ["discovery", "security", "performance", "troubleshooting", "monitoring"]
}
```

### Execute Utility

**POST** `/api/v1/utilities/{utility_name}`

#### Device Discovery Example

**POST** `/api/v1/utilities/device-discovery`

```json
{
  "network": "192.168.1.0/24",
  "timeout": 120,
  "protocols": ["ping", "snmp", "ssh"]
}
```

**Response:**
```json
{
  "execution_id": "exec_abc123",
  "status": "running",
  "started_at": "2025-10-27T12:00:00Z",
  "estimated_duration": 120,
  "progress": {
    "current_step": "Network scanning",
    "completed_percentage": 25,
    "hosts_discovered": 8
  },
  "results_url": "/api/v1/utilities/execution/exec_abc123/results"
}
```

#### SSL Diagnostics Example

**POST** `/api/v1/utilities/ssl-diagnostics`

```json
{
  "host": "secure-pos.bww.com",
  "port": 443,
  "check_chain": true,
  "check_expiration": true
}
```

**Response:**
```json
{
  "execution_id": "exec_def456",
  "status": "completed",
  "started_at": "2025-10-27T12:00:00Z",
  "completed_at": "2025-10-27T12:00:05Z",
  "results": {
    "certificate_valid": true,
    "chain_valid": true,
    "expires_at": "2025-12-31T23:59:59Z",
    "days_until_expiry": 65,
    "issuer": "Let's Encrypt",
    "algorithm": "RSA 2048",
    "san_entries": [
      "secure-pos.bww.com",
      "*.bww.com"
    ],
    "vulnerabilities": []
  }
}
```

### Get Utility Execution Status

**GET** `/api/v1/utilities/execution/{execution_id}`

```http
GET /api/v1/utilities/execution/exec_abc123
```

**Response:**
```json
{
  "execution_id": "exec_abc123",
  "utility_name": "device_discovery",
  "status": "completed",
  "started_at": "2025-10-27T12:00:00Z",
  "completed_at": "2025-10-27T12:02:15Z",
  "execution_time_ms": 135000,
  "progress": {
    "current_step": "Complete",
    "completed_percentage": 100,
    "hosts_discovered": 24
  },
  "results": {
    "total_hosts": 254,
    "responding_hosts": 24,
    "devices_identified": 18,
    "devices": [
      {
        "ip": "192.168.1.1",
        "hostname": "gateway.local",
        "device_type": "router",
        "manufacturer": "Fortinet",
        "model": "FortiGate 60F",
        "os_version": "7.2.0",
        "open_ports": [22, 80, 443],
        "snmp_sysname": "IBR-BWW-1001-FW01"
      }
    ]
  }
}
```

---

## 🎤 Voice Interface

### Voice Command Processing

**POST** `/api/v1/voice/process`

```json
{
  "command_text": "show BWW store 1001 status",
  "language": "en-US",
  "context": {
    "current_view": "dashboard",
    "user_preferences": {
      "voice_rate": 1.0,
      "voice_volume": 0.8
    }
  }
}
```

**Response:**
```json
{
  "command_id": "voice_cmd_789",
  "recognized_intent": "show_store_status",
  "extracted_entities": {
    "brand": "BWW",
    "store_id": "1001"
  },
  "execution_status": "completed",
  "response_text": "BWW store 1001 status: 5 devices online, all systems operational",
  "voice_response": true,
  "ui_updates": [
    {
      "component": "store_dashboard",
      "action": "navigate",
      "params": {
        "brand": "BWW",
        "store_id": "1001"
      }
    }
  ],
  "execution_time_ms": 250
}
```

### Voice Command History

**GET** `/api/v1/voice/history`

Query parameters:
- `limit` (optional): Number of results (default: 50)
- `offset` (optional): Pagination offset (default: 0)
- `date_from` (optional): Filter from date (ISO 8601)
- `date_to` (optional): Filter to date (ISO 8601)

```http
GET /api/v1/voice/history?limit=20
```

**Response:**
```json
{
  "commands": [
    {
      "id": "voice_cmd_789",
      "command_text": "show BWW store 1001 status",
      "recognized_intent": "show_store_status",
      "execution_status": "completed",
      "response_text": "BWW store 1001 status: 5 devices online",
      "execution_time_ms": 250,
      "created_at": "2025-10-27T12:00:00Z"
    }
  ],
  "total": 150,
  "limit": 20,
  "offset": 0
}
```

### Voice Configuration

**GET** `/api/v1/voice/config`

**Response:**
```json
{
  "voice_enabled": true,
  "supported_languages": ["en-US", "en-GB", "es-US"],
  "current_language": "en-US",
  "voice_rate": 1.0,
  "voice_volume": 0.8,
  "continuous_listening": false,
  "confidence_threshold": 0.8,
  "available_voices": [
    {
      "name": "Google US English",
      "lang": "en-US",
      "gender": "female"
    }
  ]
}
```

**PUT** `/api/v1/voice/config`

```json
{
  "voice_rate": 1.2,
  "voice_volume": 0.9,
  "continuous_listening": true,
  "confidence_threshold": 0.85
}
```

---

## 🔍 Investigation System

### Start Investigation

**POST** `/api/v1/investigations`

```json
{
  "brand": "BWW",
  "store_id": "1001",
  "time_period": "last_24h",
  "investigation_type": "performance_analysis",
  "parameters": {
    "include_device_health": true,
    "include_network_performance": true,
    "include_security_events": true
  }
}
```

**Response:**
```json
{
  "investigation_id": "inv_ghi789",
  "status": "running",
  "started_at": "2025-10-27T12:00:00Z",
  "estimated_duration": 300,
  "progress": {
    "current_phase": "Device health analysis",
    "completed_percentage": 15,
    "devices_analyzed": 2,
    "total_devices": 5
  }
}
```

### Get Investigation Status

**GET** `/api/v1/investigations/{investigation_id}`

```http
GET /api/v1/investigations/inv_ghi789
```

**Response:**
```json
{
  "investigation_id": "inv_ghi789",
  "brand": "BWW",
  "store_id": "1001",
  "status": "completed",
  "started_at": "2025-10-27T12:00:00Z",
  "completed_at": "2025-10-27T12:05:30Z",
  "findings": {
    "overall_health": "good",
    "critical_issues": 0,
    "warnings": 2,
    "recommendations": [
      {
        "priority": "medium",
        "category": "performance",
        "description": "Consider upgrading firewall memory",
        "affected_devices": ["IBR-BWW-1001-FW01"]
      }
    ],
    "device_analysis": [
      {
        "device_name": "IBR-BWW-1001-FW01",
        "health_score": 85,
        "issues": [
          {
            "severity": "warning",
            "description": "Memory usage above 80%",
            "value": 82.5
          }
        ]
      }
    ]
  }
}
```

### List Investigations

**GET** `/api/v1/investigations`

Query parameters:
- `brand` (optional): Filter by brand
- `store_id` (optional): Filter by store ID
- `status` (optional): Filter by status (running, completed, failed)
- `limit` (optional): Number of results (default: 20)

```http
GET /api/v1/investigations?brand=BWW&status=completed
```

---

## 🧠 MCP Memory System

### Search Memory

**GET** `/api/v1/memory/search`

Query parameters:
- `query` (required): Search query
- `category` (optional): Memory category filter
- `limit` (optional): Number of results (default: 10)

```http
GET /api/v1/memory/search?query=BWW%20store%201001&category=DEVICE_CONFIG
```

**Response:**
```json
{
  "results": [
    {
      "context_id": "device_config_bww_1001",
      "category": "DEVICE_CONFIG",
      "title": "BWW Store 1001 Configuration",
      "content": {
        "store_id": "1001",
        "devices": 5,
        "last_backup": "2025-10-27T06:00:00Z",
        "configuration_status": "current"
      },
      "relevance_score": 0.95,
      "created_at": "2025-10-25T10:30:00Z",
      "updated_at": "2025-10-27T06:00:00Z"
    }
  ],
  "total": 15,
  "query_time_ms": 45
}
```

### Save Memory Context

**POST** `/api/v1/memory/contexts`

```json
{
  "context_id": "investigation_bww_1001_results",
  "category": "AUTOMATION_FLOW",
  "title": "BWW Store 1001 Investigation Results",
  "content": {
    "investigation_date": "2025-10-27",
    "findings": {
      "health_score": 85,
      "issues_found": 2,
      "recommendations": 3
    }
  },
  "tags": ["BWW", "store_1001", "investigation", "performance"]
}
```

### Get Memory Categories

**GET** `/api/v1/memory/categories`

**Response:**
```json
{
  "categories": [
    {
      "name": "PROJECT_STATE",
      "description": "Project and platform state information",
      "count": 45
    },
    {
      "name": "DEVICE_CONFIG", 
      "description": "Network device configurations and backups",
      "count": 320
    },
    {
      "name": "AUTOMATION_FLOW",
      "description": "Automation workflows and results",
      "count": 180
    },
    {
      "name": "BUILD_PROGRESS",
      "description": "Build and deployment progress tracking",
      "count": 95
    },
    {
      "name": "TEST_RESULTS",
      "description": "Test execution results and reports",
      "count": 230
    },
    {
      "name": "DEPLOYMENT",
      "description": "Deployment configurations and history",
      "count": 75
    }
  ]
}
```

---

## ❌ Error Handling

### Error Response Format

All errors follow a consistent format:

```json
{
  "error": {
    "code": "DEVICE_NOT_FOUND",
    "message": "Device with ID 999 not found",
    "details": {
      "device_id": 999,
      "requested_at": "2025-10-27T12:00:00Z"
    },
    "request_id": "req_abc123"
  }
}
```

### Common Error Codes

| Code | Status | Description |
|------|--------|-------------|
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `AUTHENTICATION_REQUIRED` | 401 | Authentication token required |
| `INSUFFICIENT_PERMISSIONS` | 403 | User lacks required permissions |
| `RESOURCE_NOT_FOUND` | 404 | Requested resource not found |
| `DEVICE_NOT_FOUND` | 404 | Device not found |
| `UTILITY_NOT_AVAILABLE` | 404 | Requested utility not available |
| `RATE_LIMIT_EXCEEDED` | 429 | Rate limit exceeded |
| `FORTIMANAGER_ERROR` | 502 | FortiManager connection error |
| `UTILITY_EXECUTION_FAILED` | 502 | Utility execution failed |
| `INTERNAL_ERROR` | 500 | Internal server error |

---

## 🚦 Rate Limiting

### Rate Limits by Endpoint Category

| Category | Requests per Minute | Burst Limit |
|----------|-------------------|-------------|
| Authentication | 10 | 20 |
| Device queries | 100 | 200 |
| Utility execution | 20 | 30 |
| Voice commands | 50 | 100 |
| Memory operations | 200 | 400 |

### Rate Limit Headers

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1635789600
X-RateLimit-Category: device_queries
```

---

## 🔌 WebSocket Events

### Connection

Connect to WebSocket endpoint: `ws://localhost:5000/ws`

Authentication: Send token as first message
```json
{
  "type": "auth",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Event Types

#### Device Status Updates
```json
{
  "type": "device_status_update",
  "device_id": 123,
  "status": "online",
  "timestamp": "2025-10-27T12:00:00Z",
  "details": {
    "previous_status": "offline",
    "uptime": "00:05:23"
  }
}
```

#### Utility Execution Progress
```json
{
  "type": "utility_progress",
  "execution_id": "exec_abc123",
  "progress": {
    "completed_percentage": 75,
    "current_step": "Analyzing results",
    "estimated_remaining": 30
  }
}
```

#### Voice Command Results
```json
{
  "type": "voice_command_result",
  "command_id": "voice_cmd_789",
  "status": "completed",
  "response_text": "Investigation completed. Found 2 warnings.",
  "ui_updates": [
    {
      "component": "investigation_panel",
      "action": "update",
      "data": {...}
    }
  ]
}
```

---

## 🛠️ SDK Examples

### Python SDK Example

```python
import asyncio
import httpx
from typing import Optional, Dict, Any

class UnifiedPlatformClient:
    def __init__(self, base_url: str, token: Optional[str] = None):
        self.base_url = base_url.rstrip('/')
        self.client = httpx.AsyncClient()
        if token:
            self.client.headers.update({"Authorization": f"Bearer {token}"})
    
    async def authenticate(self, username: str, password: str) -> str:
        """Authenticate and get access token"""
        response = await self.client.post(
            f"{self.base_url}/api/v1/auth/token",
            json={"username": username, "password": password}
        )
        response.raise_for_status()
        data = response.json()
        token = data["access_token"]
        self.client.headers.update({"Authorization": f"Bearer {token}"})
        return token
    
    async def get_devices(self, brand: Optional[str] = None, 
                         store_id: Optional[str] = None) -> Dict[str, Any]:
        """Get list of devices"""
        params = {}
        if brand:
            params["brand"] = brand
        if store_id:
            params["store_id"] = store_id
            
        response = await self.client.get(
            f"{self.base_url}/api/v1/devices",
            params=params
        )
        response.raise_for_status()
        return response.json()
    
    async def execute_utility(self, utility_name: str, 
                            parameters: Dict[str, Any]) -> Dict[str, Any]:
        """Execute a network utility"""
        response = await self.client.post(
            f"{self.base_url}/api/v1/utilities/{utility_name}",
            json=parameters
        )
        response.raise_for_status()
        return response.json()
    
    async def process_voice_command(self, command_text: str) -> Dict[str, Any]:
        """Process a voice command"""
        response = await self.client.post(
            f"{self.base_url}/api/v1/voice/process",
            json={"command_text": command_text}
        )
        response.raise_for_status()
        return response.json()

# Usage example
async def main():
    client = UnifiedPlatformClient("http://localhost:5000")
    
    # Authenticate
    await client.authenticate("admin", "password")
    
    # Get BWW devices
    devices = await client.get_devices(brand="BWW")
    print(f"Found {len(devices['devices'])} BWW devices")
    
    # Execute device discovery
    result = await client.execute_utility("device_discovery", {
        "network": "192.168.1.0/24",
        "timeout": 60
    })
    print(f"Discovery started: {result['execution_id']}")
    
    # Process voice command
    voice_result = await client.process_voice_command(
        "show status for BWW store 1001"
    )
    print(f"Voice response: {voice_result['response_text']}")

if __name__ == "__main__":
    asyncio.run(main())
```

### JavaScript SDK Example

```javascript
class UnifiedPlatformClient {
    constructor(baseUrl, token = null) {
        this.baseUrl = baseUrl.replace(/\/$/, '');
        this.headers = {
            'Content-Type': 'application/json'
        };
        if (token) {
            this.headers.Authorization = `Bearer ${token}`;
        }
    }
    
    async authenticate(username, password) {
        const response = await fetch(`${this.baseUrl}/api/v1/auth/token`, {
            method: 'POST',
            headers: this.headers,
            body: JSON.stringify({ username, password })
        });
        
        if (!response.ok) {
            throw new Error('Authentication failed');
        }
        
        const data = await response.json();
        this.headers.Authorization = `Bearer ${data.access_token}`;
        return data.access_token;
    }
    
    async getDevices(filters = {}) {
        const params = new URLSearchParams(filters);
        const response = await fetch(`${this.baseUrl}/api/v1/devices?${params}`, {
            headers: this.headers
        });
        
        if (!response.ok) {
            throw new Error('Failed to get devices');
        }
        
        return await response.json();
    }
    
    async executeUtility(utilityName, parameters) {
        const response = await fetch(`${this.baseUrl}/api/v1/utilities/${utilityName}`, {
            method: 'POST',
            headers: this.headers,
            body: JSON.stringify(parameters)
        });
        
        if (!response.ok) {
            throw new Error('Utility execution failed');
        }
        
        return await response.json();
    }
    
    connectWebSocket() {
        const wsUrl = this.baseUrl.replace(/^http/, 'ws') + '/ws';
        const ws = new WebSocket(wsUrl);
        
        ws.onopen = () => {
            // Send authentication
            if (this.headers.Authorization) {
                const token = this.headers.Authorization.replace('Bearer ', '');
                ws.send(JSON.stringify({ type: 'auth', token }));
            }
        };
        
        return ws;
    }
}

// Usage example
const client = new UnifiedPlatformClient('http://localhost:5000');

// Authenticate
await client.authenticate('admin', 'password');

// Get devices
const devices = await client.getDevices({ brand: 'BWW' });
console.log(`Found ${devices.devices.length} BWW devices`);

// Connect to WebSocket for real-time updates
const ws = client.connectWebSocket();
ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log('Real-time update:', data);
};
```

---

## 📊 Response Schemas

### Device Schema
```json
{
  "type": "object",
  "properties": {
    "id": {"type": "integer"},
    "name": {"type": "string"},
    "ip_address": {"type": "string"},
    "device_type": {"type": "string"},
    "brand": {"type": "string"},
    "store_id": {"type": "string"},
    "model": {"type": "string"},
    "firmware_version": {"type": "string"},
    "status": {"type": "string", "enum": ["online", "offline", "warning", "critical"]},
    "last_seen": {"type": "string", "format": "date-time"},
    "configuration": {"type": "object"},
    "created_at": {"type": "string", "format": "date-time"},
    "updated_at": {"type": "string", "format": "date-time"}
  }
}
```

### Utility Execution Schema
```json
{
  "type": "object",
  "properties": {
    "execution_id": {"type": "string"},
    "utility_name": {"type": "string"},
    "status": {"type": "string", "enum": ["queued", "running", "completed", "failed"]},
    "started_at": {"type": "string", "format": "date-time"},
    "completed_at": {"type": "string", "format": "date-time"},
    "execution_time_ms": {"type": "integer"},
    "progress": {
      "type": "object",
      "properties": {
        "completed_percentage": {"type": "number", "minimum": 0, "maximum": 100},
        "current_step": {"type": "string"}
      }
    },
    "results": {"type": "object"}
  }
}
```

---

**API Reference Complete!** 🎉

This comprehensive API documentation covers all endpoints, authentication methods, and integration patterns for the Unified Voice-Enabled Network Management Platform. For additional examples and SDKs, see the `/examples` directory in the repository.