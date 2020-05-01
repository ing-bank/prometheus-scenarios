#!/usr/bin/env bash

# Disables the echoing of commands
stty -echo

function panic {
    echo $1
    exit 1
}

echo "Wait for katacoda"
sleep 3

echo "Deploying apps..."
cd /tmp/assets
docker-compose -f monitoring-apps.yml up -d || panic """
Error while setting up the environment.
Try to refresh the window.
"""

echo "Everything done, you can start learning!"

# Restore echo
stty echo