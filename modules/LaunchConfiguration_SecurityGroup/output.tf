output "sg_name" {
	value = "${var.sg_name}"
}
output "sg_id" {
	value = "${aws_security_group.launch_secgroup.id}"
}