resource "aws_elb" "elb"{
	name                        = "${var.elb_name}"
	availability_zones          = "${var.av_zones}"
	security_groups             = ["${var.security_group}"]
			
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