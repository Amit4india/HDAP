#!/bin/bash
cp /var/lib/jenkins/terrformIp/ip-sonar  $WORKSPACE/sonar/Sonar_Ansible/dev
cp /var/lib/jenkins/terrformIp/ip-sonar  $WORKSPACE/sonar/Sonar_Ansible/vars
cd $WORKSPACE/sonar/Sonar_Ansible/dev
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-sonar)/" inventory
cd $WORKSPACE/sonar/Sonar_Ansible/vars
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-sonar)/" input.json
