#!/usr/bin/env bash

echo "Wait for katacoda"
sleep 3

echo "Deploying apps..."
docker-compose up -f monitoring-apps.yml
