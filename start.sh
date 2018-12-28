#!/bin/bash
export AWS_PROFILE="sela"
pulumi stack init jenkins-eks
pulumi stack select jenkins-eks
kubectl config use-context aws
pulumi up
