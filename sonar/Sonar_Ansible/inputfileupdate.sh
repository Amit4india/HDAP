#!/bin/bash

echo "Running the script for Ansible input prams updates"

sonar_userid=$1
sonar_password=$2
sonar_port=$3
sonar_version=$4
out_File_Path=$5

echo "Received sonar_userid:  $sonar_userid, sonar_password: $sonar_password, sonar_port: $sonar_port, sonar_version: $sonar_version, out_File_Path: $out_File_Path"

cd vars/

sed -i "s/SONAR_ADMIN_USERNAME/$sonar_userid/g" input.json

sed -i "s/SONAR_ADMIN_PASSWORD/$sonar_password/g" input.json

sed -i "s/SONAR_PORT/$sonar_port/g" input.json

sed -i "s/SONAR_VERSION/$sonar_version/g" input.json

var=$(echo "$out_File_Path" | sed 's/\//\\\//g')
echo $var
sed -i "s/OUT_FILE_PATH/$var/g" input.json
