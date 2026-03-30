#!/bin/bash

[ ! -z $DEBUG ] && set -x

# Define configuration paths with environment variable support
CONFIG_PATH="${MCPO_CONFIG_PATH:-/opt/mcpo/config.json}"
DEFAULT_CONFIG_PATH="/defaults/config.json"

# Check if configuration file exists and copy default if needed
if [ ! -f "$CONFIG_PATH" ]; then
    echo "⚠️ Configuration file not found. Copying default config.json..."
    [ ! -d "$(dirname "$CONFIG_PATH")" ] && mkdir -p "$(dirname "$CONFIG_PATH")"
    cp "$DEFAULT_CONFIG_PATH" "$CONFIG_PATH"
fi

# Echo configuration path for debugging
echo "🚀 Launching mcpo with: $CONFIG_PATH"

# Handle API key - check if environment variable is set
if [ -n "$MCPO_API_KEY" ]; then
    echo "🔑 API key detected, adding --api-key"
    exec mcpo --config "$CONFIG_PATH" --api-key "$MCPO_API_KEY"
else
    exec mcpo --config "$CONFIG_PATH"
fi
