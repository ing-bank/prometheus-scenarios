#!/bin/bash
# configure kubectl
cp /etc/kubernetes/admin.conf .kube/config

# deploy apps
kubectl -f deployment.yml
