resource "tls_private_key" "jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins" {
  key_name   = "${var.project_name}-${var.environment}-jenkins-key"
  public_key = tls_private_key.jenkins.public_key_openssh
}

resource "aws_security_group" "jenkins_sg" {
  name        = "${var.project_name}-${var.environment}-jenkins-sg"
  description = "Allow SSH (22) and Jenkins (8080)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "jenkins" {
  ami                         = "ami-0c101f26f147fa7fd" # Amazon Linux 2
  instance_type               = "t3.medium"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jenkins.key_name
  iam_instance_profile        = var.instance_profile

  user_data = file("${path.module}/install.sh")

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-jenkins"
  })
}
