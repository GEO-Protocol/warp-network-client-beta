#!/bin/sh

if [ "$1" = "" ]; then
    echo "You should pass HOST of the node as a parameter to docker run."
    echo "Example: docker run -i -t geo-node 0.0.0.0"
    exit
fi

# Update node host in convenience with parameter received from `docker run`.
# Example: docker run -p 127.0.0.1:3000:3000/tcp -i -t geo-node 0.0.0.0
# In this case `$1` would be set to `0.0.0.0`.
sed -i "s/x.x.x.x/$1/g" /node/client/conf.json

# Run node and HTTP API of the node.
# `seep 2` is neede for proper node initialization.
./interface start > /dev/null
if [ $? -eq 0 ]; then
    sleep 2
    
    # Run HTTP interface
    ./interface http &
    if [ $? -eq 0 ]; then
        echo "HTTP API Started"
        # ToDo: Add link to the API Docs
    fi
    
    # Run bash session.
    # useful for development purposes.
    echo "Starting bash session..."
    bash
    
else
    echo "Can't start the node!"
    exit
fi
