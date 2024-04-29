#!/bin/bash

# Step 1: Build the Docker image
docker build -t myyyyyyy-new-with-pymodrev-and-modrev .

# Check if build succeeded
if [ $? -eq 0 ]; then
    echo "Build succeeded, running the container..."

    # Step 2: Run the Docker container
    docker run -it -p 8888:8888 --rm myyyyyyy-new-with-pymodrev-and-modrev:latest
else
    echo "Build failed, not running the container."
fi

