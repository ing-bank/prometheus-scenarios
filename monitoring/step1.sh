#!/bin/bash

check_k8s_ready() {
  return kubectl get nodes --no-headers | grep "Ready"
}

echo "Copying kubernetes config"
cp /etc/kubernetes/admin.conf .kube/config

echo "Waiting for kubernetes to start"
i=0
while [ $i -lt 10 ]; do
  i=$((i+1))
  echo "Attempt nr $i"
  [ check_k8s_ready ] && break
  sleep 2
done

# deploy apps
echo "Deploying apps"
kubectl apply -f /tmp/deployment.yml
