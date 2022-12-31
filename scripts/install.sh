#!/bin/bash 
set -x
echo $OSTYPE

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    #sudo yum update -y
    sudo yum install ansible -y
else 
    sudo apt -y update && sudo apt-get -y upgrade
    sudo apt -y install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt -y update
    sudo apt -y install ansible    
fi