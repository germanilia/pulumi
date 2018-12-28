#!/bin/bash

# exit if a command returns a non-zero exit code and also print the commands and their args as they are executed
set -e -x

#install plugins
pulumi plugin install resource aws v0.16.5

stack="$(pulumi stack ls | egrep ${1} | tr -s ' ' | cut -d ' ' -f 1)"

#if requested stack is not yet created > create it
if [ -z "$stack" ]
then
      pulumi stack init ${1}
      pulumi config set aws:region ${2}
else
      pulumi stack select ${1}
fi

#start the enviorment
pulumi up --yes