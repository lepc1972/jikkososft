# VPC
cidr_block      = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

# ALB
alb_name            = "my-alb"
alb_security_groups = ["sg-abc123"]
alb_port            = 80

# AutoScaling
autoscaling_name        = "my-app"
autoscaling_ami_id      = "ami-12345678"
autoscaling_instance_type = "t2.micro"
autoscaling_user_data    = "user_data.sh"
autoscaling_security_groups = ["sg-abc123"]
autoscaling_desired_capacity = 2
autoscaling_max_size         = 5
autoscaling_min_size         = 1

# DNS
dns_domain_name = "example.com"
dns_record_name = "app.example.com"

# AWS Provider
aws_region  = "us-east-2"
aws_profile = "default"

