#!/usr/bin/env bash

echo "Wait for katacoda"
sleep 3

echo "Deploying apps..."
docker-compose -f monitoring-apps.yml up
