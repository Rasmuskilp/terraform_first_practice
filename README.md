# This is our first terraform

This is our first terraform project.
Terraform is an orchestration tool, which will deploy AMIs into the cloud.
It can use many providers and use different types of images and/or provisioning.
In our stack we have:
- chef - configuration management
- packer - createsv immutable images of our machines
- Terraform is the orchestration tool that will setup the infrastructure in the cloud
#export DB_HOST=mongodb://${pub_ip}:27017/posts
## In order to get the app running with posts
## set the ip address in export DB_HOST to the db one
#do seeds/seed.js
## then run the app
