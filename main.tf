terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "3.52.1" # Use the latest compatible version
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your specific IP or range (e.g., "203.0.113.0/32")
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_access_sg"
  }
}

# Creating 2 ec2 instances
resource "aws_instance" "ec2_instance" {
  count         = 2
  ami           = "ami-0c02fb55956c7d316" # Replace with your Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id] # Associate the SG
  tags = {
    Name = "Terraform-EC2-${count.index + 1}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

 # Commands to install Datadog
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y wget",
      "sudo DD_API_KEY=${var.datadog_api_key} DD_SITE=\"us5.datadoghq.com\" bash -c \"$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)\"",
      "sudo systemctl start datadog-agent"
	]
}
}
