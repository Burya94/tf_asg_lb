resource "aws_security_group" "launch_secgroup" {
  name = "${var.sg_name}"
  description = "Allow 22port for EPAM and 8080 for ELB"

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
       }

  ingress {
      from_port       = 8080
      to_port         = 8080
      protocol        = "tcp"
      security_groups = ["${var.security_group}"]
  }
  
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
