"use strict";

const aws = require("@pulumi/aws");

let size = "t2.micro"; // t2.micro is available in the AWS free tier

let ami = "ami-6869aa05"; //us-east-1

let group = new aws.ec2.SecurityGroup("web-secgrp", {
  ingress: [
    { protocol: "tcp", fromPort: 22, toPort: 22, cidrBlocks: ["0.0.0.0/0"] }
  ]
});

let userData = `#!/bin/bash
echo "Hello, World!" > index.html
nohup python -m SimpleHTTPServer 80 &`;

let server = new aws.ec2.Instance("web-server-www", {
  tags: { Name: "web-server-www" },
  instanceType: size,
  securityGroups: [group.name],
  ami: ami,
  userData: userData
});

exports.publicIp = server.publicIp;
exports.publicHostName = server.publicDns;
