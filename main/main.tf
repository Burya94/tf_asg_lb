provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "launch_conf_secg"{}

module "launc_conf" {}

module "asg" {}

module "elb_secg" {}

module "elb" {}
