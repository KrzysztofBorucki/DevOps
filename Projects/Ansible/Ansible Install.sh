#!/bin/bash

# Installing Dependencies
echo "*************************************"
echo "Installing packages."
echo "*************************************"
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
echo

# Installing Ansible
echo "*************************************"
echo "Installing ansible."
echo "*************************************"
sudo apt update
sudo apt install ansible -y
echo


# Remove asking for key fingerprint durning ssh:
echo "*************************************"
echo "Remove asking for key fingerprint durning ssh:"
echo "*************************************"
cd /etc/ansible
mv ansible.cfg ansible.cfg.backup 
ansible-config init --disabled -t all > ansible.cfg
sed -i 's/;host_key_checking=True/host_key_checking=False/' /etc/ansible/ansible.cfg
echo
