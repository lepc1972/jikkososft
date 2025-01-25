provider "aws" {
region = var.region
}

# Get list of AZs
data "aws_availability_zones" "available" {
state = "available"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Subnets
resource "aws_subnet" "public" {
count                   = length(var.aws_subnet_public)
vpc_id                  = aws_vpc.main.id
cidr_block              = var.aws_subnet_public[count.index]
availability_zone       = data.aws_availability_zones.available.names[count.index]
map_public_ip_on_launch = true
tags = {
    Name = "Public-${count.index + 1}"
}
}

resource "aws_subnet" "private" {
vpc_id            = aws_vpc.main.id
cidr_block        = var.aws_subnet_private[0]
availability_zone = "us-east-2a"
tags = {
    Name = "Private"
}
}
# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id

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
}

# Application Load Balancer (ALB)
resource "aws_lb" "main" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "main" {
  name     = "my-target-group"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# Launch Template
resource "aws_launch_template" "main" {
  name          = "my-launch-template"
  instance_type = var.instance_type
  image_id      = var.ami # Reemplazar con la AMI deseada
}

# Auto Scaling Group
resource "aws_autoscaling_group" "main" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
  vpc_zone_identifier = aws_subnet.private[*].id
}

# Route 53 Record
resource "aws_route53_record" "main" {
  zone_id = var.zone_id # Reemplazar con el ID de la zona de Route 53
  name    = "app.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}
