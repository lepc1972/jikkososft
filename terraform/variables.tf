# VPC
variable "cidr_block" {
  description = "Bloque CIDR para la VPC"
}
variable "public_subnets" {
  description = "Lista de subredes públicas"
}
variable "private_subnets" {
  description = "Lista de subredes privadas"
}

# ALB
variable "alb_name" {
  description = "Nombre del Load Balancer"
}
variable "alb_security_groups" {
  description = "Grupos de seguridad para el ALB"
}
variable "alb_port" {
  description = "Puerto para el ALB"
  default     = 80
}

# AutoScaling
variable "autoscaling_name" {
  description = "Nombre del grupo de Auto Scaling"
}
variable "autoscaling_ami_id" {
  description = "AMI para las instancias"
}
variable "autoscaling_instance_type" {
  description = "Tipo de instancia para Auto Scaling"
}
variable "autoscaling_user_data" {
  description = "Script de inicialización para las instancias"
}
variable "autoscaling_security_groups" {
  description = "Grupos de seguridad para las instancias"
}
variable "autoscaling_desired_capacity" {
  description = "Capacidad deseada para el Auto Scaling"
  default     = 2
}
variable "autoscaling_max_size" {
  description = "Tamaño máximo para el Auto Scaling"
  default     = 5
}
variable "autoscaling_min_size" {
  description = "Tamaño mínimo para el Auto Scaling"
  default     = 1
}

# DNS
variable "dns_domain_name" {
  description = "Nombre de dominio para la configuración de DNS"
}
variable "dns_record_name" {
  description = "Nombre del registro para apuntar al ALB"
}

# AWS Provider
variable "aws_region" {
  description = "Región de AWS"
  default     = "us-east-2"
}
variable "aws_profile" {
  description = "Perfil de AWS configurado localmente"
  default     = null
}
