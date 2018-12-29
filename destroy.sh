#!/bin/bash
export AWS_PROFILE="sela"
pulumi stack select jenkins
kubectl config use-context aws
pulumi destroy --yes
