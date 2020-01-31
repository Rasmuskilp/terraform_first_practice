variable "vpc_id" {
description = "the vpc id of which the app is launched"
}
variable "Name" {
  description = "name interpolated from original main and variables tf files"
}
variable "ami" {
  description = "ami interpolated from original main and variables"
}
variable "gateway_id" {
description = "the gateway id for the app"
}
variable "pub_ip" {
description = "the generated public_ip"
}
variable "pri_ip" {
description = " the generated private_ip"
}
variable "priv_ip" {
description = " the generated private_ip"
}
