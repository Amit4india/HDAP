#!/bin/bash
terraform output | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > ip-jenkins
cp ip-jenkins /var/lib/jenkins/terrformIp

