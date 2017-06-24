resource "aws_instance" "web"{
  count             = 5
  ami               = "ami-772aa961"
  instance_type     = "t2.micro"
  key_name          = "artem_buria"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name = "web-${count.index}"
  }
}
