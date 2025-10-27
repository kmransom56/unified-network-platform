# Multi-stage Docker build for Unified Voice-Enabled Network Management Platform

# =============================================================================
# Base Stage - Common dependencies and setup
# =============================================================================
FROM python:3.11-slim as base

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Build tools
    build-essential \
    gcc \
    g++ \
    # Network tools
    curl \
    wget \
    net-tools \
    iputils-ping \
    nmap \
    # SSL/TLS tools
    ca-certificates \
    openssl \
    # Audio/Voice support
    alsa-utils \
    pulseaudio \
    # Git for version control
    git \
    # Process management
    supervisor \
    # Cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create application user
RUN groupadd --gid 1000 platform \
    && useradd --uid 1000 --gid platform --shell /bin/bash --create-home platform

# Set working directory
WORKDIR /app

# =============================================================================
# Dependencies Stage - Install Python packages
# =============================================================================
FROM base as dependencies

# Install Python dependencies
COPY requirements.txt pyproject.toml ./

# Install uv for faster package management (optional)
RUN pip install uv

# Install production dependencies
RUN uv pip install --system -r requirements.txt

# Install additional network tools
RUN uv pip install --system \
    netmiko \
    paramiko \
    scapy \
    python-nmap \
    prometheus-client

# =============================================================================
# Development Stage - Development environment with dev tools
# =============================================================================
FROM dependencies as development

# Install development dependencies
RUN uv pip install --system \
    pytest \
    pytest-asyncio \
    pytest-cov \
    pytest-mock \
    black \
    isort \
    flake8 \
    mypy \
    pre-commit

# Install Node.js for web development (optional)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Copy source code
COPY --chown=platform:platform . .

# Set ownership
RUN chown -R platform:platform /app

# Switch to non-root user
USER platform

# Expose ports
EXPOSE 5000 9090

# Development command
CMD ["python", "src/rest_api_server.py", "--debug"]

# =============================================================================
# Testing Stage - Run tests
# =============================================================================
FROM development as testing

# Switch back to root for test setup
USER root

# Install additional test dependencies
RUN uv pip install --system \
    coverage \
    bandit \
    safety

# Switch back to platform user
USER platform

# Run tests
RUN python -m pytest tests/ -v --cov=src --cov-report=xml --cov-report=html

# Security scan
RUN bandit -r src/ -f json -o bandit-report.json || true

# Safety check for vulnerabilities
RUN safety check --json --output safety-report.json || true

# =============================================================================
# Production Stage - Optimized production image
# =============================================================================
FROM base as production

# Install only production system dependencies
RUN apt-get update && apt-get install -y \
    # Runtime dependencies only
    curl \
    ca-certificates \
    openssl \
    # Audio support for voice interface
    alsa-utils \
    # Process monitoring
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy Python environment from dependencies stage
COPY --from=dependencies /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=dependencies /usr/local/bin/ /usr/local/bin/

# Create application directories
RUN mkdir -p /app/data /app/logs /app/.claude-memory \
    && chown -R platform:platform /app

# Copy application code
COPY --chown=platform:platform src/ ./src/
COPY --chown=platform:platform web/ ./web/
COPY --chown=platform:platform .claude/ ./.claude/
COPY --chown=platform:platform .mcp/ ./.mcp/
COPY --chown=platform:platform tools/ ./tools/
COPY --chown=platform:platform config/ ./config/
COPY --chown=platform:platform scripts/ ./scripts/

# Copy configuration files
COPY --chown=platform:platform requirements.txt pyproject.toml .env.example ./

# Copy startup scripts
COPY --chown=platform:platform scripts/docker-entrypoint.sh /usr/local/bin/
COPY --chown=platform:platform config/supervisor/ /etc/supervisor/conf.d/

# Make scripts executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chmod +x scripts/*.py

# Switch to non-root user
USER platform

# Set Python path
ENV PYTHONPATH=/app/src:/app

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Expose ports
EXPOSE 5000 9090

# Volume mounts for persistence
VOLUME ["/app/data", "/app/logs", "/app/.claude-memory"]

# Default entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Default command
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "--worker-class", "uvicorn.workers.UvicornWorker", "src.rest_api_server:app"]

# =============================================================================
# Nginx Stage - Web server for static files and reverse proxy
# =============================================================================
FROM nginx:alpine as nginx

# Copy web assets
COPY --from=production /app/web/static/ /usr/share/nginx/html/static/

# Copy nginx configuration
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/sites-available/ /etc/nginx/conf.d/

# Create directories for logs and SSL
RUN mkdir -p /var/log/nginx /etc/nginx/ssl

# Expose ports
EXPOSE 80 443

# Health check for nginx
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# =============================================================================
# Build Information
# =============================================================================

# Labels for image metadata
LABEL maintainer="Network Operations Team <network-team@company.com>" \
      version="2.0.0" \
      description="Unified Voice-Enabled Network Management Platform" \
      org.opencontainers.image.title="Unified Network Platform" \
      org.opencontainers.image.description="Voice-Enabled AI-Powered Restaurant Network Management" \
      org.opencontainers.image.url="https://github.com/your-org/unified-network-platform" \
      org.opencontainers.image.source="https://github.com/your-org/unified-network-platform" \
      org.opencontainers.image.version="2.0.0" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${BUILD_REV}" \
      org.opencontainers.image.licenses="ISC"