#!/bin/bash

# ====================================================
# Script to Set GitHub Repository Secrets Using GitHub CLI
# ====================================================
# This script sets secrets for a GitHub repository using the GitHub CLI.
# It requires the GitHub CLI tool (gh) to be installed and authenticated.
# Secrets are loaded from a specified .pem file and a list of key-value pairs.
# ====================================================

# --------------- CONFIGURATION ---------------

# Replace with your actual GitHub repository (format: user/repo)
REPO="shankarlmc/shanakrlmc"

# Path to the SSH private key file to be loaded as a secret
SSH_PRIVATE_KEY_FILE="/Users/shankarlmc/.ssh/id_ed25519"

# Other secrets in the format "SECRET_NAME=value"
SECRETS=(
    "SERVER_HOST=host_address"
    "SSH_USER=ssh_username"
    "SSH_PORT=22"
    "WORK_DIR=project_work_dir"
)

# --------------- SCRIPT FUNCTIONS ---------------

# Function to check if GitHub CLI is installed
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        echo "Error: GitHub CLI (gh) is not installed."
        echo "Please install GitHub CLI by following these instructions:"
        echo ""
        echo "### Installation Instructions"
        echo "1. For macOS, you can install via Homebrew:"
        echo "   \`brew install gh\`"
        echo ""
        echo "2. For Ubuntu/Debian, you can install using the following commands:"
        echo "   \`sudo apt update\`"
        echo "   \`sudo apt install gh\`"
        echo ""
        echo "3. For Windows, you can install using Scoop or download the installer directly:"
        echo "   - Scoop: \`scoop install gh\`"
        echo "   - Download: https://github.com/cli/cli/releases/latest"
        echo ""
        echo "4. For other systems, refer to the official installation guide:"
        echo "   https://cli.github.com/manual/installation"
        exit 1
    fi
}

# Function to load SSH private key from .pem file
load_ssh_private_key() {
    if [[ -f "$SSH_PRIVATE_KEY_FILE" ]]; then
        SSH_PRIVATE_KEY=$(<"$SSH_PRIVATE_KEY_FILE")
        SECRETS+=("SSH_PRIVATE_KEY=$SSH_PRIVATE_KEY")
    else
        echo "Error: SSH private key file not found at $SSH_PRIVATE_KEY_FILE"
        exit 1
    fi
}

# Function to set a GitHub secret
set_github_secret() {
    local SECRET_NAME=$1
    local SECRET_VALUE=$2

    echo "Setting secret: $SECRET_NAME"
    echo "$SECRET_VALUE" | gh secret set "$SECRET_NAME" --repo "$REPO"

    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to set secret $SECRET_NAME"
    else
        echo "Successfully set secret $SECRET_NAME"
    fi
}

# --------------- SCRIPT EXECUTION ---------------

# Ensure GitHub CLI is installed
check_gh_cli

# Load SSH private key
load_ssh_private_key

# Set each secret in GitHub repository
for SECRET in "${SECRETS[@]}"; do
    IFS='=' read -r SECRET_NAME SECRET_VALUE <<< "$SECRET"
    set_github_secret "$SECRET_NAME" "$SECRET_VALUE"
done

echo "All secrets have been set successfully."

# ====================================================
# End of Script
# ====================================================
