#!/bin/bash

echo "Running the script for Ansible input prams updates"

jenkins_userid=$1
jenkins_password=$2
jenkins_port=$3
jenkins_version=$4
outFilePath=$5

echo "Received jenkins_userid:  $jenkins_userid, jenkins_password: $jenkins_password,jenkins_port: $jenkins_port,jenkins_version: $jenkins_version, outFilePath: $outFilePath"

cd vars/

sed -i "s/JENKINS_ADMIN_USERNAME/$jenkins_userid/g" input.json

sed -i "s/JENKINS_ADMIN_PASSWORD/$jenkins_password/g" input.json

sed -i "s/JENKINS_PORT/$jenkins_port/g" input.json

sed -i "s/JENKINS_VERSION/$jenkins_version/g" input.json

sed -i "s/OUT_FILE_PATH/$outFilePath/g" input.json
