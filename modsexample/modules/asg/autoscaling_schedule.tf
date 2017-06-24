resource "aws_autoscaling_schedule" "test" {
  scheduled_action_name  = "testdz"
  min_size               = 3
  max_size               = 5
  desired_capacity       = 4
  start_time             = "2017-06-08T9:00:00Z"
  end_time               = "2017-06-08T12:00:00Z"
  autoscaling_group_name = "${aws_autoscaling_group.testscale.name}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "ausc_conf" {
  name_prefix   = "terra_lc_example"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "aws_autoscaling_group" "testscale" {
  availability_zones        = ["us-east-1a"]
  name                      = "terraasg_test"
  launch_configuration      = "${aws_launch_configuration.ausc_conf.name}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 3

  lifecycle {
    create_before_destroy = "true"
  }
}
