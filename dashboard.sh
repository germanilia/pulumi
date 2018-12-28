#!/bin/bash
export AWS_PROFILE="sela"
kubectl config use-context aws
cluster="$(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')"
token="$(kubectl -n kube-system describe secret ${cluster})"
echo "token: ${token}"
KUBECONFIG=./kubeconfig.json kubectl proxy
