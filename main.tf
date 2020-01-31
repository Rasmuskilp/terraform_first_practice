#set a provider
provider "aws" {
  region = "eu-west-1"
}
# create vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
  Name = var.Name
  }
}

# security
resource "aws_internet_gateway" "app_gateway" {
vpc_id = aws_vpc.app_vpc.id
tags = {
Name = var.Name
}
}
#call module to create app_tier
module "app" {
  source = "./modules/app_tier"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gateway.id
  Name = var.Name
  ami = var.ami
  pub_ip = module.db.pub_ip
  pri_ip = module.db.pri_ip
  priv_ip = module.db.priv_ip
}
module "db" {
  source = "./modules/db_tier"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gateway.id
  Name = var.Name_two
  app_security_group_id = module.app.app_security_group_id
  ami = var.ami2
}


#call module to create db_tier
