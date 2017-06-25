variable "asg_name" {default = "autoscaling_group"}
variable "av_zones" {
	type = "list"
	default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "hlth_ck_type" { default = "ELB"}
variable "mnsize" {default = 3}
variable "mxsize" {default = 6}
variable "hc_grace" {default = 5}
variable "lnch_conf" {}
variable "load_balancer" {}