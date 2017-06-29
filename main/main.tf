provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "elb_secg" {
	source = "../modules/ELBSecGroup"
}

module "launch_conf_secg"{
	source         = "../modules/LaunchConfiguration_SecurityGroup"
	security_group = "${module.elb_secg.elbsg_id}"
}

module "launch_conf" {
	source         = "../modules/LaunchConfiguration"
	security_group = "${module.launch_conf_secg.sg_id}"
}


module "elb" {
	source         = "../modules/ELB"
	security_group = "${module.elb_secg.elbsg_id}"
	av_zones       = "${module.asg.av_zones}"
}

module "asg" {
	source        = "../modules/AutoScalingGroup"
	lnch_conf     = "${module.launch_conf.lconf_id}"
	load_balancer = "${module.elb.elb_id}"
}
