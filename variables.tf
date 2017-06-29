variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "env" {}
variable "elbsg_name" {default = "ELBSecurityGroup"}
variable "sg_name" {default = "LaunchConfiguration_SecGroup"}
variable "lc_name" {default = "launch_conf"}
variable "key_name" {default = "artem"}
variable "instance_type" {default = "t2.micro"}
variable "elb_name" {default = "LoadBalancer"}
variable "av_zones"{}
variable "asg_name" {default = "autoscaling_group"}
variable "hlth_ck_type" { default = "ELB"}
variable "mnsize" {default = 3}
variable "mxsize" {default = 6}
variable "hc_grace" {default = 5}
