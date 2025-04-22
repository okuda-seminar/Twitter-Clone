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

resource "aws_security_group" "postgres_sg" {
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
    Name = "${var.env}-x-clone-postgres-sg"
  }
}

resource "aws_instance" "postgres" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  # User data script to install Docker, Docker Compose, Git, clone repo, and run compose.
  # TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/699
  # - Enable SSH access to EC2 and verify successful instance setup.
  # user_data = <<-EOF
  #             #!/bin/bash
  #             set -e

  #             echo "Starting user data script..."

  #             # Install updates, Docker, Git
  #             echo "Updating packages and installing Docker and Git..."
  #             dnf update -y
  #             dnf install -y docker git

  #             echo "Enabling and starting Docker service..."
  #             systemctl enable docker
  #             systemctl start docker

  #             echo "Adding ec2-user to docker group..."
  #             usermod -a -G docker $(whoami)

  #             echo "Installing Docker Compose v2..."
  #             mkdir -p /usr/local/libexec/docker/cli-plugins
  #             curl -sSL "https://github.com/docker/compose/releases/download/v2.35.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/libexec/docker/cli-plugins/docker-compose
  #             chmod +x /usr/local/libexec/docker/cli-plugins/docker-compose

  #             echo "Cloning repository..."
  #             git clone https://github.com/okuda-seminar/Twitter-Clone /home/ec2-user/app

  #             echo "Running docker compose..."
  #             cd /home/ec2-user/app/go
  #             sudo docker compose up -d

  #             echo "User data script finished."
  #             EOF

  tags = {
    Name = "${var.env}-x-clone-postgres"
  }
}
