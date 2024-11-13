#!/bin/bash
cp /var/lib/jenkins/terrformIp/ip-jenkins  $WORKSPACE/jenkins/Jenkins_Ansible/dev
cp /var/lib/jenkins/terrformIp/ip-jenkins  $WORKSPACE/jenkins/Jenkins_Ansible/vars
cp /var/lib/jenkins/terrformIp/ip-jenkins  $WORKSPACE/jenkins/Jenkins_Ansible/
cd $WORKSPACE/jenkins/Jenkins_Ansible/dev
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-jenkins)/" inventory
cd $WORKSPACE/jenkins/Jenkins_Ansible/vars
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-jenkins)/" input.json
cd $WORKSPACE/jenkins/Jenkins_Ansible/
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-jenkins)/" JenkinsParams.yml
