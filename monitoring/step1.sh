#!/bin/bash
# configure kubectl
echo "Copying kubernetes config"
cp /etc/kubernetes/admin.conf .kube/config

echo "Waiting for kubernetes to start"
i=0
while [ kubectl get nodes --no-headers | grep Ready ] || [ $i -lt 10 ]; do
  i=$((i+1))
  sleep 2
done

# deploy apps
echo "Deploying apps"
kubectl -f deployment.yml
