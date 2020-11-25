#!/bin/bash

echo "Stopping containers"
docker-compose -p "nextcloud-fullstack" down

echo "Downloading latest images from docker hub ...be patient"
docker-compose -p "nextcloud-fullstack" pull

echo "Building images if needed"
docker-compose -p "nextcloud-fullstack"  build

echo "Starting stack up again"
docker-compose -p "nextcloud-fullstack" -f docker-compose.yaml up -d 

echo "Consider running prune-images to free up space"
