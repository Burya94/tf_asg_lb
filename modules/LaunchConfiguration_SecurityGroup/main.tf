resource "aws_securtiy_group" "lauch_secgroup" {
  name = "ssh_web"
  description = "Allow 22port for EPAM and 8080 for ELB"
  ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_ip   = ["0.0.0.0/0"]
       }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocl     = "tcp"
    ####ELB SECGROUP
  }

}
