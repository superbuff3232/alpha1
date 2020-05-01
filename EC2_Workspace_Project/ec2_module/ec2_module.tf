variable "vpcid" {
  type = "string"
  default = "REMOVED"
}

resource "aws_security_group" "terraform_ec2_sg" {
  name        = "terraform_ec2_sg"
  description = "terraform test sg for ec2 instance"
  vpc_id      = "${var.vpcid}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "amiid" {
  default = "ami-097834fcb3081f51a"
}

module "shared_vars" {
  source = "../shared_vars"
}

variable "sg_id" {}
variable "ec2_name" {
  default = "EC2_Name_Instance_${module.shared_vars.env_suffix}"
}

resource "aws_instance" "terraform_ec2_instance" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "terraform-test"
  vpc_security_group_ids = ["${var.sg_id}"]

  tags = {
    Name = "${var.ec2_name}"
  }
}

