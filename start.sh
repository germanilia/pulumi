#!/bin/bash
export AWS_PROFILE="sela"
pulumi stack init jenkins
pulumi stack select jenkins
kubectl config use-context aws
pulumi up --yes
