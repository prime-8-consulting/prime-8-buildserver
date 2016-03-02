output "buildserver_security_group" {
  value = "${aws_security_group.buildserver-sg.id}"
}

output "buildserver_ip" {
  value = "${aws_instance.buildserver.private_ip}"
}

output "buildserver_id" {
  value = "${aws_instance.buildserver.id}"
}
