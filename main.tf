# VPC
resource "aws_vpc" "example_vpc" {
cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "example-vpc"
  }
}
 
# Subnet
resource "aws_subnet" "example_subnet" {
vpc_id = aws_vpc.example_vpc.id
cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "example-subnet"
  }
}
 
# Internet Gateway
resource "aws_internet_gateway" "example_igw" {
vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "example-igw"
  }
}
 
# Route Table
resource "aws_route_table" "example_route_table" {
vpc_id = aws_vpc.example_vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.example_igw.id
  }
 
  tags = {
    Name = "example-route-table"
  }
}
 
# Associate Route Table with Subnet
resource "aws_route_table_association" "example_rta" {
subnet_id = aws_subnet.example_subnet.id
route_table_id = aws_route_table.example_route_table.id
}
 
# Security Group
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Allow SSH and HTTP traffic"
vpc_id = aws_vpc.example_vpc.id
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "example-sg"
  }
}
 
# Key Pair
resource "aws_key_pair" "example_key" {
  key_name   = "EC2-key"
  public_key = var.public_key # SSH public key passed dynamically
}
 
# EC2 Instance VM-1
resource "aws_instance" "VM1" {
ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
subnet_id = aws_subnet.example_subnet.id
  key_name      = aws_key_pair.example_key.key_name
security_groups = [aws_security_group.example_sg.name]
 
  tags = {
    Name = "VM-1"
  }
}
 
# EC2 Instance VM-2
resource "aws_instance" "VM2" {
ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
subnet_id = aws_subnet.example_subnet.id
  key_name      = aws_key_pair.example_key.key_name
security_groups = [aws_security_group.example_sg.name]
 
  tags = {
    Name = "VM-2"
  }
}
 
# Data source for Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}