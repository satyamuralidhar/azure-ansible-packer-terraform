## **create a hcl file like below values:**

        azure.hcl ==> create outside of the git repo
        client_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        subscription_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        tenant_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        client_secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"


**commands:** 
---
    $ git clone repo 
    $ cd repo
    $ terraform init
    $ terraform workspace new dev
    $ terraform workspace select dev
    $ terraform init
    $ terraform validate
    $ terraform plan
    $ terraform apply --auto-approve 
    $ terraform destroy --auto-approve
---
**Try after succesfully completion of terraform** 

    http://public_ip:80/lamp.php
