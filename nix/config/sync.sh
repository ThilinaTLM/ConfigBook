#!/bin/bash

# Automatically determine the path of the script and thus the repo
SCRIPT_DIR=$(dirname "$0")
REPO_CONFIG_PATH=$(realpath "$SCRIPT_DIR")
NIXOS_CONFIG_PATH="/etc/nixos"

# Function to backup current system configuration
backup_config() {
    echo "Backing up current system configuration..."
    cp -r "$NIXOS_CONFIG_PATH" "${NIXOS_CONFIG_PATH}/backup_$(date +%Y%m%d%H%M%S)"
}

# Function to sync from repo to system
sync_from_repo() {
    backup_config
    echo "Syncing from repo to system..."
    sudo cp -r "$REPO_CONFIG_PATH/"* "$NIXOS_CONFIG_PATH"
    sudo rm "$NIXOS_CONFIG_PATH"/sync.sh
}

# Function to sync from system to repo
sync_to_repo() {
    echo "Syncing from system to repo..."
    cp -r "$NIXOS_CONFIG_PATH/"* "$REPO_CONFIG_PATH"
}

# Main script
echo "NixOS Configuration Sync Script"
echo "1. Sync from Repo to System"
echo "2. Sync from System to Repo"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "Warning: This will replace your current system configuration with the one from the repo."
        read -p "Are you sure? (y/n): " confirm
        if [[ $confirm == "y" ]]; then
            sync_from_repo
        else
            echo "Operation cancelled."
        fi
        ;;
    2)
        sync_to_repo
        ;;
    *)
        echo "Invalid choice. Exiting."
        ;;
esac
