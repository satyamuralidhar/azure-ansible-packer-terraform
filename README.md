create a hcl file like below values:
=====================================
azure.hcl
client_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
subscription_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
tenant_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/n
client_secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"


commands: 
==========
git clone repo 
cd repo
terraform init
terraform workspace new dev
terraform workspace select dev
terraform init
terraform validate
terraform plan
terraform apply --auto-approve 
terraform destroy --auto-approve

