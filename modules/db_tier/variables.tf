variable "vpc_id" {
  description = "the vpc id of which the app is launched"
}
variable "Name" {
  description = "name interpolated from original main and variables tf files"
}
variable "gateway_id" {
  description = "the gateway id for the app"
}
variable "app_security_group_id" {
description = "the variable to interpolate the security group"
}
variable "ami" {
description = " ami for the second instance -db"
}
