#!/bin/bash
export AWS_PROFILE="sela"
pulumi up
pulumi stack output kubeconfig >kubeconfig.json
cp kubeconfig.json /Users/iliagerman/.kube/pulumi_config