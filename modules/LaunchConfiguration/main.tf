data "aws_ami" "ubuntu14" {
	most_recent = true

	filter {
		name = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
	}

	filter {
		name = "virtualization-type"
		values = ["hvm"]

	}

	owners = ["099720109477"]

}

resource "aws_launch_configuration" "launch_conf" {
	name = "${var.name}"
	image_id = "ami-7bb88d6d" #"${data.aws_ami.ubuntu14.id}"
	instance_type = "${var.instance_type}"
	key_name = "${var.key_name}"
	security_groups = ["${var.security_group}"]
	
    lifecycle {
		create_before_destroy = true
	}
}