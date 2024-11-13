#!/bin/bash
echo "Running the script for node-ip input prams updates in kubernetes config file"

node_ip=$1
echo "Received node_ip:  $node_ip"

sed -i "s/INPUT_NODE_IP/$node_ip/g" k8s-wso2-config.yaml
