output "buildserver_security_group" {
  value = "${aws_security_group.buildserver-sg.id}"
}

output "buildserver_private_ip" {
  value = "${aws_instance.buildserver.private_ip}"
}

output "buildserver_public_ip" {
  value = "${aws_instance.buildserver.public_ip}"
}

output "buildserver_id" {
  value = "${aws_instance.buildserver.id}"
}
