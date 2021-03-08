provider "aws" {
    secret_key = var.secret_key
    access_key = var.access_key
    region = "us-east-1"
}
variable "access_key"{
    description = " admin user access_key"
}

variable "secret_key"{
    description = "Admin user secret key"
}

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "terrafrom-vpc"
    }
}

variable "cidr_block" {
    description = "CIRD range for the subnet"
}

resource "aws_subnet" "subnet-1a"{
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.cidr_block
    availability_zone="us-east-1a"
}

output "vpc-id" {
    value = aws_vpc.demo-vpc.id
}

output "subnet-1a" {
    value = aws_subnet.subnet-1a.id
}
resource "aws_security_group" "terraform-SG" {
  name        = "terraform-SG"
  description = "Allow SSH "
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    description = "ssh"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      Name = "terraform-SG1"
  }
}



resource "aws_instance" "test-instance"{
    ami = "ami-013f17f36f8b1fefb"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet-1a.id
    key_name = "terraform_learning"
    security_groups =  [aws_security_group.terraform-SG.id]
    tags = {
        Name = "terraform-instance"
    }
}

