variable "vpcid" {
  type = "string"
  default = "vpc-04c59cad0e5b8e23d"
}

module "shared_vars"{
  source = "../shared_vars"
}

variable "sg_name" {
  default = "sg_name_${module.shared_vars.env_suffix}"
}

resource "aws_security_group" "sg_module_creation" {
  name        = "${var.sg_name}"
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

output "sg_id_output" {
    value = "${aws_security_group.sg_module_creation.id}"
}