#!/usr/bin/env bash

function panic {
    echo $1
    exit 1
}

echo "Wait for katacoda"
sleep 3

echo "Deploying apps..."
docker-compose -d -f monitoring-apps.yml up || panic """
Error while setting up the environment.
Try to refresh the window.
"""

echo "Everything done, you can start learning!"