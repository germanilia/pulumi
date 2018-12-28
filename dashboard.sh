#!/bin/bash
export AWS_PROFILE="sela"
pulumi stack output kubeconfig >kubeconfig.json
cp kubeconfig.json /Users/iliagerman/.kube/pulumi_config
cluster="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')"
token="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system describe secret ${cluster}) | grep token"
echo "token: ${token}"
KUBECONFIG=./kubeconfig.json kubectl proxy
