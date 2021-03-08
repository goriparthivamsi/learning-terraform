provider "aws" {
  access_key = "AKIA3JYZVAFTMBIBKWGM"
  secret_key = "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"
  region = "us-east-1"
}

resource "aws_vpc" "terraform-vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terrafrom-vpc"
  }
}

variable "cidr_blocks" {
  description = "This variable is a list of cidr_blocks uses in our vpc"
  type = list(string)
}

resource "aws_subnet" "just-1" {
  cidr_block = var.cidr_blocks[0]
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "just-2" {
  cidr_block = var.cidr_blocks[1]
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1b"
}
resource "aws_subnet" "just-3" {
  cidr_block = var.cidr_blocks[2]
  vpc_id = aws_vpc.terraform-vpc.id
  availability_zone = "us-east-1c"
}

output "vpc_id" {
  value = aws_vpc.terraform-vpc.id
}
output "subnet-1a" {
  value = aws_subnet.just-1.id
}
output "subnet-2a" {
  value = aws_subnet.just-2.id
}
output "subnet-3a" {
  value = aws_subnet.just-3.id
}
