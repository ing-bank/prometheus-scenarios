#!/usr/bin/env bash

echo "Wait for katacoda"
sleep 20

mkdir .kube
while [ ! -f /etc/kubernetes/admin.conf ]; do 
  echo "Kubernetes is being installed..."
  sleep 2; 
done
cp /etc/kubernetes/admin.conf .kube/config

i=0
while [ $i -lt 30 ]; do
  echo "Waiting for kubernetes to start..."
  i=$((i+1))
  (kubectl get nodes --no-headers 2>/dev/null | grep -v "NotReady" | grep "Ready" ) && break
  sleep 3
done
history -c
# deploy apps
echo "Deploying apps"
kubectl apply -f /tmp/deployment.yml
