#!/bin/bash

set -e  # Exit on any error

echo "=== Starting Docker Notes App Deployment ==="

# Update system
sudo apt update && sudo apt upgrade -y

# Clone repository
if [ ! -d "docker-notes-app" ]; then
    git clone https://github.com/pravindeshmukh8702/docker-notes-app.git
fi
cd docker-notes-app

# Install Docker
sudo apt install docker.io -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

# Apply group changes without logout
echo "Applying Docker group permissions..."
newgrp docker << EOF
echo "Inside new group context, starting application..."
docker-compose up -d
echo "Application started!"
EOF

echo "=== Deployment Complete! ==="
echo "Check running containers: docker ps"
echo "Check logs: docker-compose logs"
