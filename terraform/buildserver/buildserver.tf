variable "prime_aws_access_key" {}
variable "prime_aws_secret_access_key" {}
variable "deploy_subnet" {}
variable "buildserver_ami" {}

provider "aws" {
    access_key  = "${var.prime_aws_access_key}"
    secret_key  = "${var.prime_aws_secret_access_key}"
    region      = "us-west-2"
}

resource "aws_security_group" "buildserver-sg" {
  name        = "buildserver-sg"
  description = "rules for buildserver access"
  vpc_id      = "vpc-d65bbab2"
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["73.239.176.112/32", "63.158.104.50/32"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.239.176.112/32", "63.158.104.50/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "buildserver" {
  ami             = "${var.buildserver_ami}"
  instance_type   = "t2.medium"
  key_name        = "bootstrap"
  security_groups = ["${aws_security_group.buildserver-sg.id}"]
  subnet_id       = "${var.deploy_subnet}"
  connection {
    user      = "ubuntu"
    key_file  = "/home/prime8/.ssh/bootstrap.pem"
  }

  tags {
    Name = "buildserver-Dev"
  }
}
