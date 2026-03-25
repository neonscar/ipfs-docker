#!/bin/bash

set -e

echo "IPFS_PATH: $IPFS_PATH"

# Initialize IPFS if not already initialized
if [ ! -f "$IPFS_PATH/config" ]; then
    echo "Initializing IPFS node..."
    ipfs init

    echo "Configuring IPFS API and Gateway..."

    # Allow external access
    ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
    ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

    # Optional: allow CORS for browser UI
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT","POST","GET"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization","Content-Type"]'

fi

echo "Starting IPFS daemon..."
exec ipfs daemon --migrate=true
