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
#create a subnet for app
resource "aws_subnet" "app_subnet" {
  vpc_id = "${aws_vpc.app_vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
  Name = var.Name
  }
}
#aws security group creation
resource "aws_security_group" "app_sg_80" {
  name = "eng48-rasmus-app"
  description = "Allow :80 inbound traffic"
  vpc_id = "${aws_vpc.app_vpc.id}"
  tags = {
  Name = var.Name
  }
  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}
#Route table
resource "aws_route_table" "app_route" {
vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_gateway.id
    }
  tags = {
  Name = var.Name
  }
}
# Route table associations
resource "aws_route_table_association" "app_assoc" {
subnet_id = aws_subnet.app_subnet.id
route_table_id = aws_route_table.app_route.id

}
# security
resource "aws_internet_gateway" "app_gateway" {
vpc_id = aws_vpc.app_vpc.id
tags = {
Name = var.Name
}
}
#Launch an instance
resource "aws_instance" "app_instance" {
ami          = "ami-0d8e5cfe85e85b81b"
subnet_id = "${aws_subnet.app_subnet.id}"
vpc_security_group_ids = ["${aws_security_group.app_sg_80.id}"]
instance_type = "t2.micro"
associate_public_ip_address = true
user_data = data.template_file.app_init.rendered
tags = {
  Name = var.Name
}
}
# Send bash script - sh file
data "template_file" "app_init" {
  template = "${file("./scripts/init_script.sh.tpl")}"
}
