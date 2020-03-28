#!/bin/bash
echo "Wait for katacoda"
sleep 10

mkdir .kube
cp /etc/kubernetes/admin.conf .kube/config

echo "Waiting for kubernetes to start"
i=0
while [ $i -lt 30 ]; do
  i=$((i+1))
  echo "Attempt nr $i"
  (kubectl get nodes --no-headers | grep "Ready") && break
  sleep 2
done

# deploy apps
echo "Deploying apps"
kubectl apply -f /tmp/deployment.yml
