#!/bin/bash
cp /var/lib/jenkins/terrformIp/ip-nexus  $WORKSPACE/nexus/Nexus_Ansible/dev
cp /var/lib/jenkins/terrformIp/ip-nexus  $WORKSPACE/nexus/Nexus_Ansible/vars
cd $WORKSPACE/nexus/Nexus_Ansible/dev
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-nexus)/" inventory
cd $WORKSPACE/nexus/Nexus_Ansible/vars
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-nexus)/" input.json