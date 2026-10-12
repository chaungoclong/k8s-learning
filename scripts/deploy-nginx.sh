#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k8s-learning"

kind create cluster \
  --name "$CLUSTER_NAME" \
  --config kind/kind-config.yaml \
  --image kindest/node:v1.31.0

kubectl config use-context "kind-$CLUSTER_NAME"

kubectl apply -f manifests/

echo "Waiting for nginx pods..."
kubectl wait \
  --for=condition=Available \
  deployment/nginx \
  -n demo \
  --timeout=120s

kubectl get pods -n demo
kubectl get svc nginx -n demo

echo "Open: http://localhost:30080"