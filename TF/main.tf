provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  #filter {
   # name   = "virtualization-type"
    #values = ["hvm"]
  #}
}


resource "aws_key_pair" "ec2_key" {
  key_name   = "tf_kluc"
  public_key = file("/home/p/.ssh/id_rsa.pub")
}


resource "aws_security_group" "ec2_secgroup" {
  name        = "SecgroupEC2"
  description = "SSH pristup"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound any any"
  }

  tags = {
    Name        = "EC2_SSH"
    Environment = "TEST"
  }
}

resource "aws_instance" "ec2_ssh" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_secgroup.id]

}
