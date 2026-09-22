#!/bin/sh

set -e

echo "======================================"
echo "        NGINX SMOKE TEST"
echo "======================================"

echo
echo "1. Checking NGINX Deployment..."
kubectl get deployment nginx -n nginx

echo
echo "2. Checking NGINX Service..."
kubectl get service nginx -n nginx

echo
echo "3. Testing NGINX HTTP endpoint..."

HTTP_STATUS=$(wget -qO- --server-response \
  http://nginx.nginx.svc.cluster.local 2>&1 \
  | awk '/^  HTTP\// {print $2}' \
  | tail -1)

echo "HTTP Status: ${HTTP_STATUS}"

if [ "$HTTP_STATUS" = "200" ]; then
    echo
    echo "======================================"
    echo "       NGINX TEST PASSED"
    echo "======================================"
    exit 0
else
    echo
    echo "======================================"
    echo "       NGINX TEST FAILED"
    echo "======================================"
    exit 1
fi
