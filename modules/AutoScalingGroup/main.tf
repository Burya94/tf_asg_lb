resource "aws_autoscaling_group" "asg" {
	availability_zones        = "${var.av_zones}"
	name                      = "${var.asg_name}"
	launch_configuration      = "${var.lnch_conf}"
	load_balancers            = ["${var.load_balancer}"]
	min_size                  = "${var.mnsize}"
	max_size                  = "${var.mxsize}"
	health_check_type         = "${var.hlth_ck_type}"
	health_check_grace_period = "${var.hc_grace}"
}