#!/bin/bash
echo "Wait for katacoda"
sleep 10

mkdir .kube
while [ ! -f /etc/kubernetes/admin.conf ]; do 
  echo "Waiting for kubernetes to be installed"
  sleep 2; 
done
cp /etc/kubernetes/admin.conf .kube/config

echo "Waiting for kubernetes to start"
i=0
while [ $i -lt 30 ]; do
  i=$((i+1))
  echo "Attempt nr $i"
  (kubectl get nodes --no-headers | grep "Ready" 2>/dev/null) && break
  sleep 2
done

# deploy apps
echo "Deploying apps"
kubectl apply -f /tmp/deployment.yml
