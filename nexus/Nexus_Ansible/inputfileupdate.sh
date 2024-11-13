#!/bin/bash

echo "Running the script for Ansible input prams updates"

nexus_userid=$1
nexus_password=$2
nexus_port=$3
nexus_version=$4
outFilePath=$5

echo "Received nexus_userid:  $nexus_userid, nexus_password: $nexus_password, nexus_port: $nexus_port,nexus_version: $nexus_version, outFilePath: $outFilePath"

cd vars/

sed -i "s/NEXUS_ADMIN_USERNAME/$nexus_userid/g" input.json

sed -i "s/NEXUS_ADMIN_PASSWORD/$nexus_password/g" input.json

sed -i "s/NEXUS_PORT/$nexus_port/g" input.json

sed -i "s/NEXUS_VERSION/$nexus_version/g" input.json

sed -i "s/OUT_FILE_PATH/$outFilePath/g" input.json
