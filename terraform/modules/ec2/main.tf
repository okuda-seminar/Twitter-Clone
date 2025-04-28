data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }

  tags = {
    Name = "amazon-linux-2023"
  }
}

resource "aws_security_group" "backend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-x-clone-backend-sg"
  }
}

resource "aws_instance" "backend" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Install docker, git, ec2-instance-connect.
    sudo dnf update -y
    sudo dnf install -y docker git ec2-instance-connect

    # Install docker compose.
    sudo mkdir -p /usr/local/libexec/docker/cli-plugins
    sudo curl -sSL -o /usr/local/libexec/docker/cli-plugins/docker-compose "https://github.com/docker/compose/releases/download/v2.35.1/docker-compose-linux-x86_64"
    sudo chmod +x /usr/local/libexec/docker/cli-plugins/docker-compose

    # Clone repo and run compose.
    git clone https://github.com/okuda-seminar/Twitter-Clone /home/ec2-user/Twitter-Clone
    cd /home/ec2-user/Twitter-Clone/go
    cp .env.sample .env
    docker compose up -d

    EOF

  tags = {
    Name = "${var.env}-x-clone-backend"
  }
}
