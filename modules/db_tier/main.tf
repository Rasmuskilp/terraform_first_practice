resource "aws_security_group" "sg-db-80" {
  name = "eng48-rasmus-db"
  description = "Allow traffic from app to db"
  vpc_id = var.vpc_id
  tags = {
  Name = var.Name
  }
  ingress {
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  #security_groups = []
  #cidr_blocks = ["0.0.0.0/0"]
  security_groups = [var.app_security_group_id]
  }
  ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_groups = [var.app_security_group_id]
  }
  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_groups = [var.app_security_group_id]
  #cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_groups = [var.app_security_group_id]
  }
  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}
#create a subnet for app
resource "aws_subnet" "db_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
  Name = var.Name
  }
}
#Route table
#resource "aws_route_table" "db_route" {
#vpc_id = var.vpc_id
#route {
#  cidr_block = "0.0.0.0/0"
#  gateway_id = var.gateway_id
#  }
#  tags = {
#  Name = var.Name
#  }
#}
# Route table associations
#resource "aws_route_table_association" "db_assoc" {
#subnet_id = aws_subnet.db_subnet.id
#route_table_id = aws_route_table.db_route.id
#}
#Launch an instance
resource "aws_instance" "db_instance" {
ami          = var.ami
subnet_id = "${aws_subnet.db_subnet.id}"
vpc_security_group_ids = [aws_security_group.sg-db-80.id]
instance_type = "t2.micro"
key_name = "rasmus_kilp_eng48_first_key"
associate_public_ip_address = true
tags = {
  Name = var.Name
}
provisioner "local-exec" {
    command = "echo ${aws_instance.db_instance.*.public_ip} > ip_address.txt"
  }
}
