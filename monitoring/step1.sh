#!/bin/bash
# configure kubectl
echo "Copying kubernetes config"
cp /etc/kubernetes/admin.conf .kube/config

# deploy apps
echo "Deploying apps"
kubectl -f deployment.yml
