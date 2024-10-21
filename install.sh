#!/bin/bash

# Check for Python 3.10+ installation
if ! command -v python3 &> /dev/null || ! python3 -c 'import sys; assert sys.version_info >= (3, 10)' &> /dev/null; then
    echo "Python 3.10+ is required. Please install it and try again."
    exit 1
fi

# Check for the existence of requirements.txt and create it if it does not exist
if [ ! -f requirements.txt ]; then
    echo "Creating requirements.txt file..."
    echo "qdrant-client" > requirements.txt
fi

# Install necessary libraries
pip install -r requirements.txt

# Set up Docker for support_bot
if ! command -v docker &> /dev/null; then
    echo "Docker is required for support_bot. Please install Docker and try again."
    exit 1
fi

cd examples/support_bot
docker-compose up -d
cd ../..

# Install dependencies from setup.cfg
pip install -e .

echo "Installation complete. You can now run the examples."
