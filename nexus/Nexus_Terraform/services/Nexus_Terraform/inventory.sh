#!/bin/bash
terraform output | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > ip-nexus
cp ip-nexus /var/lib/jenkins/terrformIp

