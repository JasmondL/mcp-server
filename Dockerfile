FROM python:3.12-slim

# Install Node.js environment
RUN apt-get update && apt-get install -y \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && pip install --no-cache-dir uv \
    && uv venv /venv

ENV VIRTUAL_ENV=/venv \
    PATH="/venv/bin:$PATH"

RUN npm install -g @modelcontextprotocol/server-filesystem @modelcontextprotocol/server-memory @modelcontextprotocol/server-sequential-thinking \
    && uv pip install mcpo mcp-server-time mcp-server-fetch \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy initialization script and config files
COPY config/init.sh /usr/local/bin/init.sh
COPY config/config.json /defaults/config.json

# Make init script executable
RUN chmod +x /usr/local/bin/init.sh

# Set entrypoint to run the init script
CMD ["/usr/local/bin/init.sh"]
