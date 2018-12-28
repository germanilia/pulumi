#!/bin/bash
cluster="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')"
token="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system describe secret ${cluster}) | grep token"
KUBECONFIG=./kubeconfig.json kubectl proxy
echo "token: ${token}"