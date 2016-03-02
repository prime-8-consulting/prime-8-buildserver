variable "aws_access_key" {}
variable "aws_secret_access_key" {}
variable "buildserver_subnet" {}
variable "buildserver_ami" {}

provider "aws" {
    access_key  = "${var.aws_access_key}"
    secret_key  = "${var.aws_secret_access_key}"
    region      = "us-west-2"
}

resource "aws_security_group" "buildserver-sg" {
  name        = "buildserver-sg"
  description = "rules for buildserver access"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["73.239.176.112/32"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["73.239.176.112/32"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = ["73.239.176.112/32"]
  }
  ingress {
    from_port   = 8111
    to_port     = 8111
    protocol    = "tcp"
    cidr_blocks = ["73.239.176.112/32"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "buildserver" {
  ami             = "#{var.buildserver_ami}"
  instance_type   = "t2.medium"
  key_name        = "bootstrap"
  security_groups = ["${aws_security_group.buildserver-sg}"]
  subnet_id       = "${var.buildserver_subnet}"
  connection {
    user      = "ubuntu"
    key_file  = "/home/prime8/.ssh/bootstrap.pem"
  }

  tags {
    Name = "buildserver-Dev"
  }
}
