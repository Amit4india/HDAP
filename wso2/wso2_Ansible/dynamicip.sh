#!/bin/bash
cp /var/lib/jenkins/terrformIp/ip-wso2  $WORKSPACE/wso2-setup/wso2_Ansible/dev
cp /var/lib/jenkins/terrformIp/ip-wso2  $WORKSPACE/wso2-setup/wso2_Ansible/dev/group_vars
cp /var/lib/jenkins/terrformIp/ip-wso2  $WORKSPACE/wso2-setup/wso2_Ansible/dev/host_vars
cd $WORKSPACE/wso2-setup/wso2_Ansible/dev
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-wso2)/" inventory
cd $WORKSPACE/wso2-setup/wso2_Ansible/dev/group_vars
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-wso2)/" apim.yml
cd $WORKSPACE/wso2-setup/wso2_Ansible/dev/host_vars
sed -i "s/Enter_IP/$(sed 's:/:\\/:g' ip-wso2)/" apim_1.yml
cd /home/users/amit_srivastava/wsofiles
cp wso2am-3.0.0.zip $WORKSPACE/wso2_setup/wso2_Ansible/files/packs/
cp amazon-corretto-8.242.08.1-linux-x64.tar.gz $WORKSPACE/wso2_setup/wso2_Ansible/files/lib/