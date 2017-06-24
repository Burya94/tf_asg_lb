resource "aws_vpc" "testterr" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "test_subnet1a" {
  vpc_id            = "${aws_vpc.testterr.id}"
  depends_on        = ["aws_vpc.testterr"]
  cidr_block        = "172.16.16.0/20"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "test_subnet1b" {
  vpc_id            = "${aws_vpc.testterr.id}"
  depends_on        = ["aws_vpc.testterr"]
  cidr_block        = "172.16.32.0/20"
  availability_zone = "us-east-1b"
}
