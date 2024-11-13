#!/bin/bash
terraform output | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > ip-sonar
cp ip-sonar /var/lib/jenkins/terrformIp

