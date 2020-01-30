output pub_ip {
  description = "This is the db's generated public ip"
  value = aws_instance.db_instance.*.public_ip
}
