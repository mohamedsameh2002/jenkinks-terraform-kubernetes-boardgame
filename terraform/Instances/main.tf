# =========================
# Jenkins
# =========================


data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}









resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.large"

  key_name               = "workspace"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "Jenkins"
  }
}

# =========================
# Nexus
# =========================

resource "aws_instance" "nexus" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"

  key_name               = "workspace"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "Nexus"
  }
}

# =========================
# SonarQube
# =========================

resource "aws_instance" "sonarqube" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"

  key_name               = "workspace"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "SonarQube"
  }
}



resource "aws_ec2_instance_state" "jenkins" {
  instance_id = aws_instance.jenkins.id
  state       = var.instances_running ? "running" : "stopped"
}

resource "aws_ec2_instance_state" "nexus" {
  instance_id = aws_instance.nexus.id
  state       = var.instances_running ? "running" : "stopped"
}

resource "aws_ec2_instance_state" "sonarqube" {
  instance_id = aws_instance.sonarqube.id
  state       = var.instances_running ? "running" : "stopped"
}

# =========================
# Outputs
# =========================

output "jenkins_public_hostname" {
  value = aws_instance.jenkins.public_dns
}

output "nexus_public_hostname" {
  value = aws_instance.nexus.public_dns
}

output "sonarqube_public_hostname" {
  value = aws_instance.sonarqube.public_dns
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "nexus_public_ip" {
  value = aws_instance.nexus.public_ip
}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
}