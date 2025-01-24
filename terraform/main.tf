module "vpc" {
  source          = "../modules/vpc"
  cidr_block      = var.cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "alb" {
  source          = "../modules/alb"
  name            = var.alb_name
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = var.alb_security_groups
  port            = var.alb_port
}

module "autoscaling" {
  source           = "../modules/autoscaling"
  name             = var.autoscaling_name
  ami_id           = var.autoscaling_ami_id
  instance_type    = var.autoscaling_instance_type
  user_data        = var.autoscaling_user_data
  security_groups  = var.autoscaling_security_groups
  subnets          = module.vpc.private_subnets
  desired_capacity = var.autoscaling_desired_capacity
  max_size         = var.autoscaling_max_size
  min_size         = var.autoscaling_min_size
}

module "dns" {
  source        = "../modules/dns"
  domain_name   = var.dns_domain_name
  record_name   = var.dns_record_name
  alb_dns       = module.alb.alb_dns
  alb_zone_id   = aws_lb.main.zone_id
}
