#!/bin/bash
set -x
echo $OSTYPE

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo yum update -y
    sudo yum install remove -y
else 
    sudo apt -y remove --purge ansible
    sudo apt-add-repository --remove ppa:ansible/ansible
    sudo apt -y autoremove
    sudo apt -y update
fi