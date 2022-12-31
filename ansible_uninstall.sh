#!/bin/bash
set -x
echo $OSTYPE

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo yum update -y
    sudo yum install remove -y
    sudo subscription-manager repos --disable ansible-2.9-for-rhel-8-x86_64-rpms
    sudo subscription-manager repos --disable rhel-7-server-ansible-2.9-rpms
else 
    sudo apt -y remove --purge ansible
    sudo apt-add-repository --remove ppa:ansible/ansible
    sudo apt -y autoremove
    sudo apt -y update
fi