variable "region" {
  description = "AWS region"
  type = string
  
}
variable "aws_vpc" {
  description = "VPC CIDR block"
  type = string
}
variable "aws_subnet_public" {
  description = "Public subnet CIDR block"
  type = list(string)
}
variable "aws_subnet_private" {
  description = "Private subnet CIDR block"
  type = list(string)
}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  
}
variable "ami" {
  description = "AMI"
  type = string
  
  
}
variable "zone_id" {
    description = "Route 53 zone ID"
    type = string
  
}
variable "desired_capacity" {
  description = "Desired capacity for the autoscaling group"
  type = number
  
}
variable "max_size" {
  description = "Max size for the autoscaling group"
  type = number
  
}
variable "min_size" {
  description = "Min size for the autoscaling group"
  type = number
  
}
variable "port" {
  description = "Port"
  type = number

  
}