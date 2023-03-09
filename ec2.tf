data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "architecture"
    values = ["x86_64"]
  }


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }


  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }


  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux2.image_id
  subnet_id              = data.aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.instance.id]
  instance_type          = "t2.micro"
}

resource "aws_security_group" "instance" {
  name   = "example"
  vpc_id = data.aws_subnet.main.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
