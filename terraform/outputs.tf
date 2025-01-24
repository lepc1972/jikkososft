output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "alb_dns" {
  description = "DNS del Load Balancer"
  value       = module.alb.alb_dns
}

output "autoscaling_group" {
  description = "Nombre del grupo de Auto Scaling"
  value       = module.autoscaling.name
}

output "dns_zone_id" {
  description = "ID de la zona DNS en Route 53"
  value       = module.dns.zone_id
}
