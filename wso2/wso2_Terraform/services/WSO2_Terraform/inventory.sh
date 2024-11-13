#!/bin/bash
terraform output | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' >>ip-wso2
cp ip-wso2 /var/lib/jenkins/terrformIp
