resource "aws_security_group" "elb_secgroup" {
	name        = "${var.env}${var.elbsg_name}"
	description = "Allow 80 and 443 ports to whole world"

	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

}

resource "aws_security_group" "launch_secgroup" {
	depends_on  = ["aws_security_group.elb_secgroup"]
  name        = "${var.env}${var.sg_name}"
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
      security_groups = ["${aws_security_group.elb_secgroup.id}"]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "launch_conf" {
	depends_on      = ["aws_security_group.launch_secgroup"]
	name            = "${var.env}${var.lc_name}"
	image_id        = "ami-7bb88d6d"
	instance_type   = "${var.instance_type}"
	key_name        = "${var.key_name}"
	security_groups = ["${aws_security_group.launch_secgroup.id}"]

    lifecycle {
		create_before_destroy = true
	}
}

resource "aws_elb" "elb"{
	depends_on                  = ["aws_security_group.elb_secgroup"]
	name                        = "${var.env}${var.elb_name}"
	availability_zones          = "${var.av_zones}"
	security_groups             = ["${aws_security_group.elb_secgroup.id}"]

	listener {
		instance_port     = 8080
		instance_protocol = "http"
		lb_port           = 80
		lb_protocol       = "http"
	}

	listener {
		instance_port     = 8080
		instance_protocol = "tcp"
		lb_port           = 443
		lb_protocol       = "tcp"
	}

	health_check {
		target              = "HTTP:8080/"
		healthy_threshold   = 5
		unhealthy_threshold = 3
		timeout             = 5
		interval            = 30
	}
}

resource "aws_autoscaling_group" "asg" {
	depends_on                = ["aws_elb.elb", "aws_launch_configuration.launch_conf"]
	availability_zones        = "${var.av_zones}"
	name                      = "${var.env}${var.asg_name}"
	launch_configuration      = "${aws_launch_configuration.launch_conf.id}"
	load_balancers            = ["${aws_elb.elb.id}"]
	min_size                  = "${var.mnsize}"
	max_size                  = "${var.mxsize}"
	health_check_type         = "${var.hlth_ck_type}"
	health_check_grace_period = "${var.hc_grace}"
}
