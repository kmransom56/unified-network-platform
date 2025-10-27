# Voice Commands Guide

**Unified Voice-Enabled Network Management Platform**

Complete guide to voice-enabled network operations and natural language interactions.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Core Voice Commands](#core-voice-commands)
- [Device Management](#device-management)
- [Network Utilities](#network-utilities)
- [Investigation Commands](#investigation-commands)
- [Brand-Specific Operations](#brand-specific-operations)
- [Advanced Voice Features](#advanced-voice-features)
- [Voice Command Patterns](#voice-command-patterns)
- [Troubleshooting Voice](#troubleshooting-voice)
- [Customization](#customization)

---

## 🎤 Overview

The platform features an advanced voice interface powered by Web Speech API and natural language processing. Commands are processed through pattern matching and AI-powered intent recognition.

### Voice Interface Capabilities
- **Natural Language Processing**: Understand conversational commands
- **Multi-Brand Support**: BWW, Arby's, and Sonic restaurant networks
- **Real-Time Execution**: Instant response to voice commands
- **Context Awareness**: Remember previous commands and maintain session state
- **Accessibility Support**: Compatible with screen readers and assistive technologies

### Supported Languages
- **English (US)** - `en-US` (Primary)
- **English (UK)** - `en-GB` 
- **Spanish (US)** - `es-US`

---

## 🚀 Getting Started

### 1. Enable Voice Interface

1. Open the platform in a supported browser (Chrome/Edge recommended)
2. Navigate to **Settings** → **Voice Configuration**
3. Click **Enable Voice Commands**
4. Allow microphone access when prompted
5. Test with: *"Hello platform"*

### 2. Basic Voice Settings

Configure voice parameters in Settings:
- **Speech Rate**: 0.5x to 2.0x (1.0x default)
- **Volume**: 0.0 to 1.0 (0.8 default)
- **Continuous Listening**: Enable for hands-free operation
- **Confidence Threshold**: 0.6 to 0.9 (0.8 default)

### 3. First Voice Commands

Try these basic commands to get started:

```
"Hello platform"
"Show platform status"
"What can you do?"
"Help me with voice commands"
```

---

## 🌐 Core Voice Commands

### Platform Control

| Command | Description | Example Response |
|---------|-------------|------------------|
| **"Hello platform"** | Greeting and activation | "Hello! Platform ready for commands." |
| **"Show status"** | Platform health status | "Platform healthy. 150 devices online." |
| **"What can you do?"** | List capabilities | "I can manage devices, run diagnostics..." |
| **"Show dashboard"** | Navigate to main dashboard | "Displaying main dashboard." |
| **"Help"** | Voice command help | "Here are available voice commands..." |
| **"Show settings"** | Open settings panel | "Opening platform settings." |
| **"Refresh data"** | Refresh current view | "Refreshing display data." |
| **"Go back"** | Navigate back | "Going back to previous view." |

### System Information

```
"Show platform version"
"What's the current time?"
"How many devices are online?"
"Show system health"
"Display memory usage"
"Show recent activity"
```

### Navigation Commands

```
"Go to dashboard"
"Show device list"
"Open investigation panel"
"Switch to BWW view"
"Navigate to settings"
"Show utilities panel"
```

---

## 🖥️ Device Management

### Device Discovery Commands

| Command Pattern | Parameters | Example |
|-----------------|------------|---------|
| **"Discover devices"** | Default network | "Discover devices" |
| **"Scan network {network}"** | Network range | "Scan network 192.168.1.0/24" |
| **"Find devices in {network}"** | Network range | "Find devices in 10.1.0.0/16" |
| **"Search for {brand} devices"** | Brand filter | "Search for BWW devices" |
| **"Discover devices with timeout {seconds}"** | Custom timeout | "Discover devices with timeout 120" |

### Device Status Commands

```
"Show all devices"
"List online devices"
"Show offline devices"
"Display critical devices"
"Show BWW devices"
"List devices for store 1001"
"Show device status for {device_name}"
"Display firewall status"
"Show router health"
```

### Device Operations

```
"Restart device {device_name}"
"Backup configuration for {device_name}"
"Show configuration for {device_name}"
"Update firmware on {device_name}"
"Put {device_name} in maintenance mode"
"Remove {device_name} from maintenance"
"Show logs for {device_name}"
"Display interfaces for {device_name}"
```

### Device Filtering

```
"Show only BWW devices"
"Filter by store 1001"
"Display only firewalls"
"Show devices with warnings"
"List devices updated today"
"Show devices by IP range 192.168.1.0/24"
```

---

## 🔧 Network Utilities

### SSL/Certificate Diagnostics

| Command | Description | Usage |
|---------|-------------|-------|
| **"Check SSL for {host}"** | Basic SSL check | "Check SSL for secure-pos.bww.com" |
| **"SSL diagnostics for {host}"** | Comprehensive SSL analysis | "SSL diagnostics for api.arbys.com" |
| **"Validate certificate {host}"** | Certificate validation | "Validate certificate payments.sonic.com" |
| **"Check SSL expiration {host}"** | Check certificate expiry | "Check SSL expiration secure.bww.com" |

### Network Performance Testing

```
"Test bandwidth to {host}"
"Ping {host}"
"Trace route to {host}"
"Test latency to {host}"
"Check packet loss to {host}"
"Run speed test"
"Test connectivity to headquarters"
```

### Port and Service Analysis

```
"Scan ports on {host}"
"Check open ports {host}"
"Test service on {host} port {port}"
"Scan for vulnerabilities on {host}"
"Check HTTP response for {host}"
"Test HTTPS redirect for {host}"
```

### DNS and Network Tools

```
"Lookup DNS for {domain}"
"Resolve IP for {domain}"
"Show DNS records for {domain}"
"Test DNS resolution"
"Check DNS propagation for {domain}"
"Verify reverse DNS for {ip}"
```

### Advanced Network Diagnostics

```
"Run comprehensive scan on {network}"
"Analyze network topology for {network}"
"Check DHCP on {network}"
"Scan for rogue devices"
"Monitor network traffic"
"Generate network report for {brand}"
```

---

## 🔍 Investigation Commands

### Starting Investigations

| Command Pattern | Description | Example |
|-----------------|-------------|---------|
| **"Investigate {brand} store {store_id}"** | Full store investigation | "Investigate BWW store 1001" |
| **"Run diagnostics on {brand}"** | Brand-wide diagnostics | "Run diagnostics on Arby's" |
| **"Analyze performance for {store_id}"** | Performance analysis | "Analyze performance for store 1001" |
| **"Check security for {brand} {store_id}"** | Security investigation | "Check security for Sonic store 2001" |

### Investigation Scopes

```
"Investigate all BWW stores"
"Run quick check on store 1001"
"Deep analysis of store network 1001"
"Security audit for BWW"
"Performance investigation last 24 hours"
"Check all devices in store 1001"
```

### Investigation Status

```
"Show investigation status"
"What investigations are running?"
"Show recent investigation results"
"Display investigation history"
"Show findings for store 1001"
"List all completed investigations"
```

### Investigation Results

```
"Show results for investigation {id}"
"Display recommendations for store 1001"
"What did you find in the last investigation?"
"Show critical findings"
"Display performance metrics"
"Generate investigation report"
```

---

## 🏪 Brand-Specific Operations

### Buffalo Wild Wings (BWW)

```
"Show BWW overview"
"List all BWW stores"
"BWW store 1001 status"
"Check BWW POS connectivity"
"Show BWW network health"
"BWW device inventory"
"Run BWW compliance check"
"Display BWW security status"
"BWW bandwidth utilization"
"Show BWW critical alerts"
```

### Arby's

```
"Show Arby's dashboard"
"List Arby's locations"
"Arby's store 2001 diagnostics"
"Check Arby's payment systems"
"Arby's network performance"
"Show Arby's device health"
"Run Arby's security scan"
"Arby's compliance report"
"Display Arby's alerts"
"Arby's backup status"
```

### Sonic

```
"Display Sonic overview"
"Show Sonic store locations"
"Sonic store 3001 status"
"Check Sonic drive-thru systems"
"Sonic network analysis"
"Show Sonic device status"
"Run Sonic health check"
"Sonic security assessment"
"Display Sonic performance"
"Sonic maintenance schedule"
```

### Multi-Brand Commands

```
"Compare BWW and Arby's performance"
"Show status across all brands"
"Generate multi-brand report"
"Display brand comparison metrics"
"Show worst performing stores across brands"
"List critical issues by brand"
```

---

## 🧠 Advanced Voice Features

### Context-Aware Commands

The platform remembers context from previous commands:

```
User: "Show BWW store 1001"
Platform: "Displaying BWW store 1001 dashboard."

User: "Run diagnostics"  [Context: BWW store 1001]
Platform: "Running diagnostics on BWW store 1001..."

User: "Show the results"  [Context: Recent diagnostics]
Platform: "Displaying diagnostic results for BWW store 1001..."
```

### Conditional Commands

```
"If BWW store 1001 is down, restart the firewall"
"Check SSL and if expiring soon, send alert"
"Show devices and if any are offline, investigate"
"Run scan and if critical issues found, create ticket"
```

### Batch Operations

```
"Check SSL for all BWW stores"
"Restart all offline devices"
"Backup configurations for all firewalls"
"Run diagnostics on stores 1001, 1002, and 1003"
"Update firmware on all Sonic devices"
```

### Scheduled Commands

```
"Schedule daily health check for BWW"
"Set weekly backup for all configurations"
"Schedule SSL certificate check monthly"
"Set maintenance window for store 1001 tonight"
"Schedule security scan for weekends"
```

### Voice Macros

Create custom voice macros for complex operations:

```
"Create macro called 'store health check'"
  -> "Show device status"
  -> "Check network performance" 
  -> "Run security scan"
  -> "Generate summary report"

"Run store health check for BWW 1001"
```

---

## 📚 Voice Command Patterns

### Pattern Recognition System

The platform uses advanced pattern matching to understand natural language:

#### Entity Recognition
- **Brands**: BWW, Buffalo Wild Wings, Arby's, Sonic
- **Store IDs**: 1001, 2001, 3001 (any numeric pattern)
- **IP Addresses**: 192.168.1.1, 10.0.0.0/24
- **Hostnames**: secure-pos.bww.com, api.company.com
- **Device Types**: firewall, router, switch, access point
- **Time Periods**: today, yesterday, last week, last 24 hours

#### Intent Patterns
```javascript
// Show/Display Commands
"(show|display|list) {entity} (for|in) {location}"
"what (is|are) the {entity} (status|health)"

// Action Commands  
"(run|execute|start) {action} (on|for) {target}"
"(check|test|verify) {service} (on|for) {target}"

// Navigation Commands
"(go to|navigate to|open) {view}"
"switch to {brand} (view|dashboard)"
```

### Command Variations

Most commands accept multiple variations:

**Device Status Examples:**
```
"Show device status"
"Display device health"
"What's the device status?"
"How are the devices?"
"Check all devices"
"Device health report"
```

**Network Scan Examples:**
```
"Scan the network"
"Discover devices on network"
"Find devices"
"Network discovery"
"Search for devices"
"Probe network for devices"
```

---

## 🔧 Troubleshooting Voice

### Common Voice Issues

#### 1. Voice Not Recognized
**Symptoms**: Commands not processed, no response
**Solutions**:
- Check microphone permissions
- Verify browser compatibility (Chrome/Edge recommended)
- Check microphone volume and quality
- Try speaking more clearly and slowly

#### 2. Incorrect Command Recognition
**Symptoms**: Wrong commands executed
**Solutions**:
- Lower background noise
- Speak more distinctly
- Use exact command phrases
- Check confidence threshold in settings

#### 3. No Voice Response
**Symptoms**: Commands execute but no voice feedback
**Solutions**:
- Check speaker/headphone connection
- Verify voice volume setting
- Check browser audio permissions
- Test with "Hello platform" command

### Voice Command Debugging

Enable debug mode for voice commands:

```
"Enable voice debug mode"
"Show voice command log"
"What did you hear?"
"Repeat what I said"
"Show recognition confidence"
```

### Browser-Specific Issues

#### Google Chrome
- Requires HTTPS for production use
- May require "Experimental Web Platform features" flag
- Best overall compatibility

#### Microsoft Edge
- Excellent Web Speech API support
- Similar requirements to Chrome
- Good performance on Windows

#### Firefox
- Limited Web Speech API support
- May not work with all features
- Use Chrome/Edge for best experience

#### Safari
- Very limited Web Speech API support
- Voice features may not work
- iOS Safari has additional restrictions

---

## 🎯 Customization

### Custom Voice Commands

Add custom commands for your environment:

#### 1. Environment-Specific Commands
```javascript
// Custom brand names
"Check {your_brand} store status"
"Show {your_company} network health"

// Custom device naming
"Restart POS terminal {number}"
"Check kitchen display system"
"Test drive-thru network"
```

#### 2. Role-Based Commands
```javascript
// Manager commands
"Show daily operations report"
"Display revenue impact summary"
"Check critical business systems"

// Technician commands
"Show maintenance schedule"
"Display diagnostic tools"
"Check equipment status"
```

### Voice Response Customization

Customize voice responses in settings:

```javascript
// Response styles
"Professional" // Default business tone
"Casual"       // Relaxed, friendly tone  
"Technical"    // Detailed technical language
"Brief"        // Short, concise responses
```

### Language and Accent Support

Configure language preferences:

```javascript
// Language settings
"Set voice language to Spanish"
"Use British English pronunciation"
"Enable multilingual support"

// Accent recognition
"Train for regional accents"
"Improve recognition for my voice"
"Set accent preference"
```

### Voice Command Aliases

Create shortcuts for frequently used commands:

```javascript
// Create aliases
"Create alias 'health' for 'show platform status'"
"Add shortcut 'bww1001' for 'show BWW store 1001'"
"Set quick command 'scan' for 'discover devices'"

// Use aliases
"health"     -> "show platform status"
"bww1001"    -> "show BWW store 1001" 
"scan"       -> "discover devices"
```

---

## 📊 Voice Analytics

### Command Usage Statistics

Track voice command usage:

```
"Show voice command statistics"
"What are my most used commands?"
"Display voice usage analytics"
"Show command success rate"
"Voice performance metrics"
```

### Voice Training and Improvement

Improve recognition accuracy:

```
"Train voice recognition for my voice"
"Improve recognition accuracy"
"Add voice training samples"
"Calibrate microphone settings"
"Test voice recognition quality"
```

### Voice Command Learning

The platform learns from your usage:

- **Frequently Used Commands**: Faster recognition for common commands
- **Personal Vocabulary**: Adapts to your pronunciation and accent
- **Context Learning**: Better understanding of your workflow patterns
- **Error Correction**: Learns from corrections you make

---

## 🎉 Voice Command Quick Reference

### Essential Daily Commands
```
"Hello platform"                    # Start voice session
"Show status"                       # Platform overview
"Show BWW devices"                  # Brand-specific view
"Run diagnostics on store 1001"     # Store investigation
"Check SSL for secure.bww.com"      # SSL diagnostics  
"Discover devices"                  # Network discovery
"Show recent alerts"                # Alert summary
"Generate report"                   # Create summary report
"Good night platform"               # End session
```

### Emergency Commands
```
"Show critical alerts"
"Display offline devices"
"Emergency investigation store {id}"
"Restart all offline devices"
"Check security status immediately" 
"Show system failures"
"Generate emergency report"
```

### Quick Navigation
```
"Dashboard"          -> Main dashboard
"Devices"           -> Device list
"Utilities"         -> Network tools
"Investigations"    -> Investigation panel
"Settings"          -> Configuration
"Help"              -> Command help
```

---

**Voice Commands Guide Complete!** 🎤

Your voice-enabled network management platform is ready to understand and execute natural language commands across your restaurant network infrastructure. Start with "Hello platform" and discover the power of voice-controlled network operations!

*Tip: The more you use voice commands, the better the platform becomes at understanding your unique speech patterns and preferences.*