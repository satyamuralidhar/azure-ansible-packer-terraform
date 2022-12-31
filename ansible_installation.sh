if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo yum update -y
    sudo yum install ansible -y
    sudo subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms
    sudo subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms
else 
    sudo apt -y update && sudo apt-get -y upgrade
    sudo apt -y install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt -y update
    sudo apt -y install ansible    
fi