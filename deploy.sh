#!/bin/bash

if [ $# -le 2 ]; then
    echo "Usage: $0 <image_name> <container_name> <port_num>"
    exit 1
fi

# Configuration
IMAGE_NAME="$1"
CONTAINER_NAME="$2"
if [ $# -ge 3 ]; then
    PORT_MAPPING="$3:5000"
else
    PORT_MAPPING="5000:5000"
fi
DOCKERFILE_DIR="."

# Building Docker image
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME $DOCKERFILE_DIR

# Stoping any existing container
echo "Stopping any existing container: $CONTAINER_NAME"
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

# Running the new container
echo "Starting a new container: $CONTAINER_NAME"
docker run -d --name $CONTAINER_NAME -p $PORT_MAPPING $IMAGE_NAME

echo "$CONTAINER_NAME deployed at port $3"
