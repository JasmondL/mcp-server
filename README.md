# 📦 MCP Server for OpenWebUI and Opencode

This repository provides a Docker-based Model Context Protocol (MCP) server that serves as a foundation for integrating with OpenWebUI and Opencode. It includes pre-configured MCP servers for time, web fetching, filesystem access, and sequential thinking capabilities.

## 🚀 Overview

The MCP server acts as a bridge between AI applications like OpenWebUI and Opencode and various utility services. It provides standardized interfaces for accessing time information, fetching web content, accessing the filesystem, and enabling sequential thinking processes.

## 📦 Built-in MCP Servers

The container comes with these pre-installed MCP servers:

1. 🕰️ **Time Server** - Provides current time and timezone conversion capabilities
2. 🌐 **Web Fetch Server** - Fetches and processes web content from URLs
3. 💾 **Filesystem Server** - Provides access to the container's filesystem
4. 🧠 **Memory Server** - Enables temporary data storage and retrieval
5. 🤔 **Sequential Thinking Server** - Facilitates structured problem-solving processes

## 🚀 Running the Container

### Prerequisites
- Docker installed on your system

### Build the Image
```bash
docker build -t mcp-server .
```

### Run the Container
```bash
docker run -p 8000:8000 mcp-server
```

### Run with Custom Configuration
```bash
docker run -p 8000:8000 -v /path/to/config:/opt/mcpo/config.json mcp-server
```

### Run with Mounted Directories for Filesystem Access
If you want to provide specific directories for the filesystem server to access, mount them to `/mnt` inside the container:

```bash
docker run -p 8000:8000 \
  -v /path/to/docs:/mnt/docs \
  -v /path/to/archive:/mnt/archive \
  -v /path/to/config:/opt/mcpo/config.json \
  mcp-server
```

This allows the filesystem server to access documentation in `/mnt/docs` and archives in `/mnt/archive` as configured in the default setup.

## ⚙️ Configuration

### Default Configuration

The default configuration located at `config/config.json` defines the MCP servers to be launched. Each server entry specifies:
- `command`: The command to execute (e.g., `uvx`, `npx`, `python`)
- `args`: Arguments passed to the command
- Environment variables (where applicable)

### Custom Configuration

You can provide a custom configuration file by mounting it to `/opt/mcpo/config.json`:
```bash
docker run -p 8000:8000 -v /path/to/custom-config.json:/opt/mcpo/config.json mcp-server
```

## 🔧 Adding New MCP Servers

To add support for additional MCP servers, follow these steps:

1. **Update the configuration file** (`config/config.json`):
   ```json
   {
     "mcpServers": {
       "your-new-server": {
         "command": "command-to-run",
         "args": ["arg1", "arg2"]
       }
     }
   }
   ```

2. **Modify the Dockerfile** to include the new server dependencies:
   - For Python packages: Add to the `uv pip install` command
   - For Node.js packages: Add to the `npm install` command

3. **Rebuild the container**:
   ```bash
   docker build -t mcp-server .
   ```

### Adding Python-Based Servers

To add a new Python-based MCP server:
1. Add it to the `uv pip install` line in the Dockerfile
2. Add it to the configuration in `config/config.json` with appropriate command and args

### Adding Node.js-Based Servers

To add a new Node.js-based MCP server:
1. Add it to the `npm install` line in the Dockerfile
2. Add it to the configuration in `config/config.json` with appropriate command and args

## 💻 Development

### Local Development Setup

1. Clone the repository
2. Build the Docker image:
   ```bash
   docker build -t mcp-server .
   ```
3. Run the container:
   ```bash
   docker run -p 8000:8000 mcp-server
   ```

### Testing

The MCP server is tested using standard Docker container testing procedures:
1. Run the built container
2. Verify the server is listening on port 8000
3. Test individual MCP server functionality using the MCP inspector tool

## 🌐 Integration with OpenWebUI

To connect with OpenWebUI:

1. Configure OpenWebUI to connect to this MCP server at `http://localhost:8000`
2. Ensure the MCP configuration in OpenWebUI matches your server setup
3. The configuration should reference the same MCP server names defined in `config/config.json`

## 🤖 Integration with Opencode

Opencode can utilize this MCP server by:
1. Connecting to the MCP server endpoint
2. Using the available MCP servers as tools in its workflows
3. Leveraging the standardized interfaces for consistent cross-platform compatibility

## 🔒 Security Considerations

- The filesystem server provides access to the container's filesystem - use with caution
- The web fetch server can access local/internal IP addresses - exercise caution
- All servers operate within the container's security boundaries
- Consider using environment variables for API keys and sensitive configurations

## ❓ Troubleshooting

### Connection Issues
Ensure the container is running with the correct port mapping:
```bash
docker ps
```

### Configuration Issues
Verify your configuration file syntax:
```bash
docker run --rm -v /path/to/config.json:/config.json mcp-server cat /config.json
```

### Server Startup Issues
Check container logs:
```bash
docker logs <container-id>
```

## 📚 Support

This MCP server supports the Model Context Protocol specification and is compatible with tools that implement this protocol. For more information about MCP, visit http://modelcontextprotocol.io

## 📁 Filesystem Server Mount Points

The filesystem server is configured to access directories mounted to `/mnt` inside the container. You can mount any directories you want the MCP server to access:

- `/mnt/docs` - Documentation directory
- `/mnt/archive` - Archive directory
- `/mnt/data` - General data directory

Example:
```bash
docker run -p 8000:8000 \
  -v /local/docs:/mnt/docs \
  -v /local/archive:/mnt/archive \
  mcp-server
```
