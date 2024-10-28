# GitHub Secrets Setup Script

This repository contains a shell script to automate the process of setting GitHub repository secrets using the GitHub CLI (`gh`). This script is particularly useful for configuring secrets like SSH keys, environment variables, and project-specific details in one batch.

## Prerequisites

- **GitHub CLI (`gh`)**: Ensure that the GitHub CLI is installed and authenticated.
- **Permissions**: Your GitHub account must have appropriate permissions to set secrets in the target repository.

## Running the Script
- **Make the script executable**
    ```bash
    chmod +x set_github_secrets.sh
- **Execute the script**
    ```bash
    ./set_github_secrets.sh

