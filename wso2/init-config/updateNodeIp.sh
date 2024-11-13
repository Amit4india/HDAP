#!/bin/bash
echo "Running the script for node-ip input prams updates in WSO2 init config files."

node_ip=$1
echo "Received node_ip:  $node_ip"

sed -i "s/NODE_IP/$node_ip/g" automationconfig.json
