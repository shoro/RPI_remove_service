#!/bin/bash

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root using sudo"
  exit
fi

# Check if service name is provided
if [ -z "$1" ]; then 
  echo "Usage: $0 <service_name>"
  exit
fi

SERVICE_NAME=$1

echo "Disabling the service $SERVICE_NAME..."
sudo systemctl disable $SERVICE_NAME.service

echo "Stopping the service $SERVICE_NAME..."
sudo systemctl stop $SERVICE_NAME.service

echo "Removing the service file /etc/systemd/system/$SERVICE_NAME.service..."
sudo rm /etc/systemd/system/$SERVICE_NAME.service

echo "Reloading the systemd daemon..."
sudo systemctl daemon-reload

echo "Service $SERVICE_NAME has been removed."

# Optional: Remove associated files
# Uncomment and modify the following line if you need to remove additional files
# sudo rm -rf /path/to/service/files

echo "Done."
