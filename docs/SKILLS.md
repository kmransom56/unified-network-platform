# Claude Code Skills Documentation

**Unified Voice-Enabled Network Management Platform**

Complete guide to the 8 autonomous Claude Code skills that power intelligent network operations.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Skills Architecture](#skills-architecture)
- [Network Management Skills](#network-management-skills)
- [API Development Skills](#api-development-skills)
- [Application Management Skills](#application-management-skills)
- [Skill Integration Patterns](#skill-integration-patterns)
- [Custom Skill Development](#custom-skill-development)
- [Skill Performance Metrics](#skill-performance-metrics)

---

## 🧠 Overview

The platform includes 8 specialized autonomous skills located in `.claude/skills/` that Claude Code automatically invokes when relevant tasks are detected. These skills enable multi-hour autonomous execution without message limits through MCP memory persistence.

### Skills Philosophy
- **Autonomous Operation**: Skills run independently without human intervention
- **Memory Persistence**: All state saved to external MCP memory
- **Context Awareness**: Skills share knowledge and build upon each other
- **Resumable Execution**: Any skill can be interrupted and resumed
- **Intelligent Orchestration**: Skills coordinate complex multi-step workflows

---

## 🏗️ Skills Architecture

### Skill Structure
Each skill follows a consistent structure:

```
.claude/skills/{skill-name}/
├── skill.md              # Skill definition and capabilities
├── prompts/              # Context-specific prompts
├── examples/             # Usage examples and templates
├── tools/                # Skill-specific utilities
└── memory/               # Skill memory templates
```

### Skill Lifecycle
1. **Activation**: Claude detects relevant task pattern
2. **Context Loading**: Skill loads previous state from MCP memory
3. **Planning**: Skill creates execution plan with checkpoints
4. **Execution**: Autonomous task execution with progress tracking
5. **Memory Persistence**: State saved to MCP for recovery
6. **Result Integration**: Outputs integrated into platform memory

### Skill Communication
Skills communicate through:
- **MCP Memory System**: Shared persistent state
- **Progress Tracker**: Cross-skill task coordination
- **Event System**: Real-time skill interaction
- **API Integration**: Direct platform integration

---

## 🌐 Network Management Skills

### 1. Network Inventory Skill (`network-inventory`)

**Purpose**: Multi-brand device discovery and inventory management

**Capabilities**:
- Discovers devices across BWW, Arby's, and Sonic networks
- Multi-protocol scanning (PING, SNMP, SSH, HTTP)
- Device classification and fingerprinting
- Inventory reconciliation and change detection
- Automatic device categorization and tagging

**When Activated**:
- Voice command: "Discover devices", "Scan network", "Update inventory"
- Scheduled inventory updates
- New network segment detection
- Device change notifications

**Example Usage**:
```python
# Autonomous multi-brand discovery
skill_result = network_inventory_skill.execute({
    "brands": ["BWW", "ARBYS", "SONIC"],
    "networks": ["auto-detect"],
    "protocols": ["ping", "snmp", "ssh"],
    "deep_scan": True,
    "update_inventory": True
})
```

**Memory Categories Used**:
- `DEVICE_CONFIG`: Device configurations and properties
- `PROJECT_STATE`: Discovery progress and results
- `AUTOMATION_FLOW`: Workflow coordination

**Skill Outputs**:
- Updated device inventory in MCP memory
- Network topology mapping
- Device change reports
- Security posture assessments

---

### 2. WAN Audit Skill (`wan-audit`)

**Purpose**: Autonomous WAN audit campaigns across restaurant locations

**Capabilities**:
- Multi-location WAN connectivity analysis
- Bandwidth utilization monitoring
- Latency and jitter measurements
- VPN tunnel health verification
- Automatic remediation recommendations

**When Activated**:
- Voice command: "Run WAN audit", "Check WAN performance"
- Scheduled audit campaigns (daily/weekly/monthly)
- Performance threshold violations
- Network outage investigations

**Example Usage**:
```python
# Quarterly WAN audit campaign
skill_result = wan_audit_skill.execute({
    "campaign_name": "Q4_2025_WAN_Audit",
    "locations": ["store_*"],  # All stores
    "tests": ["bandwidth", "latency", "vpn_health"],
    "duration": "24_hours",
    "auto_remediate": False
})
```

**Integration Points**:
- FortiManager API for device data
- Network monitoring systems
- Bandwidth utilization tools
- VPN endpoint monitoring

**Skill Outputs**:
- WAN performance baselines
- Connectivity quality reports
- Remediation action plans
- Historical trend analysis

---

### 3. Device Search Skill (`device-search`)

**Purpose**: Intelligent device configuration search and analysis

**Capabilities**:
- Natural language device queries
- Configuration pattern matching
- Cross-device policy comparison
- Compliance validation
- Security rule analysis

**When Activated**:
- Voice command: "Find devices with...", "Search configurations"
- Compliance audits
- Security assessments
- Configuration drift detection

**Example Usage**:
```python
# Find devices with weak encryption
skill_result = device_search_skill.execute({
    "query": "Find firewalls with weak SSL ciphers",
    "brands": ["BWW", "ARBYS"],
    "config_sections": ["ssl-settings", "vpn-config"],
    "compliance_check": True
})
```

**Advanced Search Patterns**:
- Regex pattern matching in configurations
- Cross-device rule comparisons
- Policy effectiveness analysis
- Unused rule identification

**Skill Outputs**:
- Filtered device lists with context
- Configuration analysis reports
- Compliance violation summaries
- Remediation recommendations

---

### 4. FortiManager Operations Skill (`fortimanager-ops`)

**Purpose**: Advanced FortiManager automation with persistent storage

**Capabilities**:
- Bulk device configuration management
- Policy template deployment
- Firmware upgrade orchestration
- Backup and restore operations
- Configuration drift monitoring

**When Activated**:
- Voice command: "Deploy policy", "Update firmware", "Backup configs"
- Scheduled maintenance windows
- Configuration change requests
- Emergency recovery operations

**Example Usage**:
```python
# Bulk firmware upgrade with rollback capability
skill_result = fortimanager_ops_skill.execute({
    "operation": "firmware_upgrade",
    "target_devices": "BWW_firewalls",
    "firmware_version": "7.4.0",
    "maintenance_window": "2025-11-01T02:00:00Z",
    "rollback_on_failure": True,
    "pre_backup": True
})
```

**Safety Features**:
- Automatic configuration backups
- Rollback capability
- Staged deployment with validation
- Change impact analysis

**Skill Outputs**:
- Configuration change logs
- Deployment status reports
- Pre/post validation results
- Rollback plans

---

## ⚡ API Development Skills

### 5. API Collection Parser Skill (`api-collection-parser`)

**Purpose**: Parse and analyze Postman collections for REST and JSON-RPC APIs

**Capabilities**:
- Postman collection format parsing
- REST and JSON-RPC endpoint extraction
- Authentication method detection
- Request/response schema analysis
- API documentation generation

**When Activated**:
- New Postman collection imports
- API integration planning
- Documentation generation requests
- SDK development preparation

**Example Usage**:
```python
# Parse FortiManager API collection
skill_result = api_collection_parser_skill.execute({
    "collection_path": "/collections/fortimanager_api.json",
    "output_format": "openapi_3.0",
    "include_examples": True,
    "generate_schemas": True
})
```

**Parsing Capabilities**:
- Collection metadata extraction
- Folder structure analysis
- Variable and environment handling
- Authentication flow documentation
- Error response cataloging

**Skill Outputs**:
- OpenAPI/Swagger specifications
- API endpoint catalogs
- Authentication documentation
- Request/response examples

---

### 6. API Client Generator Skill (`api-client-generator`)

**Purpose**: Generate Python API clients with comprehensive type hints

**Capabilities**:
- Async/sync client generation
- Type hint integration
- Error handling patterns
- Authentication method implementation
- Response model generation

**When Activated**:
- API integration requirements
- SDK development requests
- Type-safe API wrapper needs
- Client library updates

**Example Usage**:
```python
# Generate FortiManager Python client
skill_result = api_client_generator_skill.execute({
    "api_spec": "fortimanager_openapi.json",
    "client_name": "FortiManagerClient",
    "async_support": True,
    "type_hints": "pydantic",
    "auth_methods": ["bearer", "api_key"],
    "output_path": "src/clients/"
})
```

**Generated Features**:
- Async/await support for all endpoints
- Pydantic models for request/response
- Comprehensive error handling
- Automatic retry logic
- Rate limiting support

**Skill Outputs**:
- Complete Python API clients
- Type stub files (.pyi)
- Usage documentation
- Example integration code

---

### 7. API Integration Skill (`api-integration`)

**Purpose**: Integrate API clients into platform with MCP memory support

**Capabilities**:
- Client integration into existing codebase
- MCP memory pattern implementation
- Async workflow coordination
- Error handling and retry logic
- Performance monitoring integration

**When Activated**:
- New API client deployment
- Integration testing requirements
- Memory persistence setup
- Performance optimization needs

**Example Usage**:
```python
# Integrate new client into platform
skill_result = api_integration_skill.execute({
    "client_path": "src/clients/fortimanager_client.py",
    "integration_points": ["rest_api_server", "voice_commands"],
    "mcp_categories": ["DEVICE_CONFIG", "AUTOMATION_FLOW"],
    "monitoring": True,
    "async_patterns": True
})
```

**Integration Patterns**:
- FastAPI endpoint integration
- Voice command binding
- Background task coordination
- Error monitoring and alerting
- Performance metric collection

**Skill Outputs**:
- Integrated API endpoints
- Voice command mappings
- MCP memory configurations
- Monitoring dashboards

---

## 📱 Application Management Skills

### 8. App Consolidation Skill (`app-consolidation`)

**Purpose**: Consolidate 100+ applications autonomously with intelligent analysis

**Capabilities**:
- Application discovery and cataloging
- Dependency analysis and mapping
- Consolidation opportunity identification
- Risk assessment and mitigation
- Automated migration execution

**When Activated**:
- Application consolidation projects
- Infrastructure optimization
- Cost reduction initiatives
- Technical debt reduction

**Example Usage**:
```python
# Consolidate restaurant POS applications
skill_result = app_consolidation_skill.execute({
    "source_path": "/applications/pos_systems/",
    "consolidation_strategy": "microservices",
    "risk_tolerance": "medium",
    "preserve_data": True,
    "migration_windows": ["weekends", "off_hours"]
})
```

**Consolidation Strategies**:
- Microservices architecture
- Containerization patterns
- Database consolidation
- API gateway integration
- Service mesh deployment

**Analysis Capabilities**:
- Code similarity detection
- Database schema merging
- API endpoint unification
- Configuration harmonization
- Testing strategy generation

**Skill Outputs**:
- Consolidation execution plans
- Risk assessment reports
- Migration roadmaps
- Testing strategies

---

## 🔗 Skill Integration Patterns

### Cross-Skill Coordination

Skills work together through shared patterns:

#### Example: Comprehensive Network Assessment
```python
# Multi-skill workflow coordination
workflow = SkillOrchestrator()

# 1. Network Inventory discovers all devices
inventory_result = workflow.execute("network-inventory", {
    "brands": ["BWW", "ARBYS", "SONIC"],
    "full_discovery": True
})

# 2. Device Search finds configuration issues
search_result = workflow.execute("device-search", {
    "devices": inventory_result.devices,
    "search_patterns": ["security_vulnerabilities", "outdated_firmware"]
})

# 3. WAN Audit tests connectivity
audit_result = workflow.execute("wan-audit", {
    "target_devices": search_result.vulnerable_devices,
    "priority": "high"
})

# 4. FortiManager Ops applies fixes
remediation_result = workflow.execute("fortimanager-ops", {
    "actions": audit_result.recommended_actions,
    "schedule": "maintenance_window"
})
```

### Memory Sharing Patterns

Skills share data through MCP memory:

```python
# Skill A saves discovery results
mcp_memory.save_context(
    "network_discovery_2025_10_27",
    ContextCategory.AUTOMATION_FLOW,
    "BWW Network Discovery Results",
    {
        "devices_found": 150,
        "new_devices": 5,
        "security_issues": 12
    }
)

# Skill B loads and processes results
context = mcp_memory.load_context("network_discovery_2025_10_27")
security_issues = context.content["security_issues"]
```

### Error Recovery Patterns

Skills implement consistent error recovery:

```python
def skill_execute_with_recovery(skill_name, params):
    try:
        # Attempt execution
        result = skill.execute(params)
        
        # Save successful state
        progress_tracker.checkpoint(
            skill_name,
            {"status": "completed", "result": result}
        )
        
        return result
        
    except Exception as e:
        # Save error state
        progress_tracker.checkpoint(
            skill_name,
            {"status": "error", "error": str(e), "params": params}
        )
        
        # Attempt recovery
        return skill.recover_from_error(e, params)
```

---

## 🛠️ Custom Skill Development

### Creating New Skills

Follow these patterns when developing custom skills:

#### 1. Skill Definition (`skill.md`)
```markdown
# Custom Network Security Skill

**Purpose**: Automated security assessment and remediation

**Activation Patterns**:
- Voice commands containing "security", "vulnerability", "audit"
- Scheduled security scans
- Alert threshold violations

**MCP Memory Usage**:
- `AUTOMATION_FLOW`: Security scan progress
- `PROJECT_STATE`: Baseline security posture
- `TEST_RESULTS`: Vulnerability scan results

**Integration Points**:
- FortiManager for device configs
- Vulnerability scanners
- Compliance reporting systems
```

#### 2. Skill Implementation (`tools/security_skill.py`)
```python
from typing import Dict, Any, Optional
from ..memory.manager import MCPMemoryManager, ContextCategory
from ..progress_tracker import ProgressTracker

class NetworkSecuritySkill:
    def __init__(self):
        self.memory = MCPMemoryManager()
        self.tracker = ProgressTracker()
        
    def execute(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """Execute security assessment skill"""
        task_id = f"security_assessment_{int(time.time())}"
        
        # Create execution plan
        steps = [
            "Load device inventory",
            "Run vulnerability scans",
            "Analyze configurations",
            "Generate remediation plan",
            "Apply fixes (if authorized)"
        ]
        
        plan = self.tracker.create_plan(
            task_id,
            "Network Security Assessment",
            steps,
            params
        )
        
        try:
            # Execute each step with checkpointing
            for i, step in enumerate(steps):
                self.tracker.update_step(task_id, i, "in_progress")
                
                result = self._execute_step(step, params)
                
                self.tracker.update_step(
                    task_id, i, "completed", 
                    output=result
                )
                
                # Checkpoint progress
                self.tracker.checkpoint(task_id, {
                    "current_step": i,
                    "intermediate_results": result
                })
                
            return {"status": "completed", "task_id": task_id}
            
        except Exception as e:
            self.tracker.update_step(
                task_id, i, "failed", 
                error=str(e)
            )
            raise
```

#### 3. Integration Hooks (`prompts/activation.md`)
```markdown
## Skill Activation Criteria

This skill should be activated when:

1. **Voice Commands** containing:
   - "security scan", "security assessment"
   - "check vulnerabilities", "vulnerability scan"
   - "security audit", "compliance check"

2. **Scheduled Operations**:
   - Daily security baseline updates
   - Weekly vulnerability assessments
   - Monthly compliance reports

3. **Event Triggers**:
   - New device discoveries
   - Configuration changes
   - Security alert thresholds

4. **API Requests** to:
   - `/api/v1/security/scan`
   - `/api/v1/security/assessment`
   - `/api/v1/compliance/audit`
```

### Skill Testing Patterns

Test skills using consistent patterns:

```python
import pytest
from unittest.mock import Mock, patch
from skills.network_security_skill import NetworkSecuritySkill

@pytest.fixture
def security_skill():
    return NetworkSecuritySkill()

@pytest.fixture
def mock_memory():
    with patch('skills.memory.manager.MCPMemoryManager') as mock:
        yield mock

def test_skill_execution(security_skill, mock_memory):
    """Test complete skill execution"""
    params = {
        "brands": ["BWW"],
        "scan_type": "vulnerability",
        "auto_remediate": False
    }
    
    result = security_skill.execute(params)
    
    assert result["status"] == "completed"
    assert "task_id" in result
    
def test_skill_recovery(security_skill, mock_memory):
    """Test skill recovery from interruption"""
    task_id = "test_task_123"
    
    # Simulate interrupted execution
    security_skill.tracker.checkpoint(task_id, {
        "current_step": 2,
        "intermediate_results": {"devices_scanned": 50}
    })
    
    # Resume execution
    result = security_skill.resume(task_id)
    
    assert result["status"] == "completed"
```

---

## 📊 Skill Performance Metrics

### Execution Metrics

Track skill performance across key dimensions:

#### Completion Rates
```python
# Skill success rates by category
network_skills = {
    "network-inventory": {"success_rate": 98.5, "avg_duration": "5min"},
    "wan-audit": {"success_rate": 96.2, "avg_duration": "15min"},
    "device-search": {"success_rate": 99.1, "avg_duration": "2min"},
    "fortimanager-ops": {"success_rate": 94.8, "avg_duration": "10min"}
}

api_skills = {
    "api-collection-parser": {"success_rate": 99.5, "avg_duration": "30sec"},
    "api-client-generator": {"success_rate": 97.3, "avg_duration": "2min"},
    "api-integration": {"success_rate": 95.1, "avg_duration": "5min"}
}

app_skills = {
    "app-consolidation": {"success_rate": 92.4, "avg_duration": "45min"}
}
```

#### Memory Efficiency
```python
# MCP memory usage by skill
memory_usage = {
    "network-inventory": {
        "contexts_created": 150,
        "avg_context_size": "2.3KB",
        "retention_period": "30_days"
    },
    "wan-audit": {
        "contexts_created": 45,
        "avg_context_size": "8.7KB", 
        "retention_period": "90_days"
    }
}
```

#### Error Recovery Stats
```python
# Recovery success rates
recovery_stats = {
    "total_interruptions": 234,
    "successful_recoveries": 221,
    "recovery_success_rate": 94.4,
    "avg_recovery_time": "45_seconds"
}
```

### Performance Optimization

#### Skill Caching
```python
# Cache frequently accessed data
@lru_cache(maxsize=100)
def get_device_inventory(brand: str) -> Dict[str, Any]:
    """Cached device inventory lookup"""
    return skill.load_from_memory(f"inventory_{brand}")
```

#### Parallel Execution
```python
# Execute skills in parallel when possible
async def parallel_skill_execution(skills_and_params):
    tasks = [
        skill.execute_async(params) 
        for skill, params in skills_and_params
    ]
    results = await asyncio.gather(*tasks)
    return results
```

#### Memory Management
```python
# Automatic memory cleanup
def cleanup_old_contexts():
    """Remove contexts older than retention period"""
    for category in ContextCategory:
        old_contexts = memory.find_contexts(
            category=category,
            older_than=timedelta(days=30)
        )
        for context in old_contexts:
            memory.delete_context(context.id)
```

---

## 🎯 Skill Orchestration Examples

### Restaurant Network Assessment Workflow

Complete autonomous assessment across all brands:

```python
# Define complex multi-skill workflow
workflow_definition = {
    "name": "complete_restaurant_network_assessment",
    "skills": [
        {
            "skill": "network-inventory",
            "params": {
                "brands": ["BWW", "ARBYS", "SONIC"],
                "deep_scan": True,
                "update_topology": True
            },
            "outputs": ["device_inventory", "network_topology"]
        },
        {
            "skill": "device-search", 
            "depends_on": ["network-inventory"],
            "params": {
                "search_queries": [
                    "outdated_firmware",
                    "weak_encryption",
                    "unused_rules",
                    "configuration_drift"
                ]
            },
            "outputs": ["security_issues", "compliance_gaps"]
        },
        {
            "skill": "wan-audit",
            "depends_on": ["network-inventory"],
            "params": {
                "test_types": ["bandwidth", "latency", "vpn_health"],
                "all_locations": True
            },
            "outputs": ["performance_baselines", "connectivity_issues"]
        },
        {
            "skill": "fortimanager-ops",
            "depends_on": ["device-search", "wan-audit"],
            "params": {
                "remediation_actions": "auto_generate",
                "approval_required": True,
                "maintenance_window": "weekend"
            },
            "outputs": ["remediation_plan", "change_schedule"]
        }
    ],
    "final_outputs": [
        "comprehensive_assessment_report",
        "executive_summary", 
        "technical_recommendations",
        "remediation_roadmap"
    ]
}

# Execute workflow autonomously
orchestrator = SkillOrchestrator()
result = await orchestrator.execute_workflow(workflow_definition)
```

---

**Skills Documentation Complete!** 🧠

The 8 autonomous Claude Code skills provide comprehensive network management, API development, and application consolidation capabilities. Each skill operates independently while sharing knowledge through the MCP memory system, enabling complex multi-hour operations without message limits.

*These skills represent the AI-powered intelligence layer of your voice-enabled network management platform, providing autonomous operation capabilities that scale across hundreds of restaurant locations.*