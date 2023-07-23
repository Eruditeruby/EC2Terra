 
provider "aws" {
  region = "eu-central-1"  # Replace with your desired AWS region
}


resource "aws_security_group" "project-EC2Terra" {
  name = "EC2Terra"
  description = "EC2Terra Security Group"

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 0 - 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "EC2Kube" {
  ami = "ami-07ce6ac5ac8a0ee6f"
  instance_type = "t2.medium"
  key_name = aws_key_pair.myseckey.id
  tags = {
    Name = "EC2Kube"
    }
}
  resource "aws_key_pair" "myseckey" {
  public_key = var.pub_key
  // public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCRT94sjRL1vXJnf/0yWL6tBWz/GSv9kIyC6aUloznlA7hv7vp8EihxKPLGm6HsjZH4UI7GSAd6RC0TSNZqzXKWaB745A+Nz2Kq+NAq8+KJunSIvh1N5ze8zflY8VLSdtO0lUdAdxay7FsTD7pYNMQfLrUuPj0c2SwBJUn5GT40d8IsRobuuIx4e1GdEJWVMhmhUDN7nRq39Tzvul7MCYV/Ohud54cJL8amiw4mkJgmUBaRmhoNIsDTdfkAFdLPkwR5y1Zgpj/JBiJCiKBjzAV3PETKTD91WGpq4kl9FMv7eqTYZOlpVOZOL2iXxTr2d0nYfsp1OvIVhDXm3ZSqJ3Dp"
}
