output pub_ip {
  description = "This is the db's generated public ip"
  value = aws_instance.db_instance.*.public_ip
}
output pri_ip {
  description = "This is the db's generated prviate ip"
  value = aws_instance.db_instance.*.private_ip
}
output priv_ip {
  description = "This is the db's generated prviate ip"
  value = aws_instance.db_instance.private_ip
}
