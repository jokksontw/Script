#!/bin/bash
sudo apt-get -y install ansible
sudo apt-get -y install sshpass
sudo ansible-galaxy install ihrwein.syslog-ng
sudo ansible-galaxy install jdauphant.nginx
sudo ansible-galaxy install zenoamaro.postgresql

#Run example
#ansible-playbook -v -i ~/hosts xxxxxxxx.yml

#~/hosts content example
#[Developer]
#192.168.1.22 ansible_connection=ssh ansible_ssh_user=root ansible_ssh_pass=ROOT_PASSWORD
