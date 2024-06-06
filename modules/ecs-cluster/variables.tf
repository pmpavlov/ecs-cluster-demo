variable "vpc_id" {
  type = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "public_subnet_1" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

variable "private_subnet_1" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "db_subnet_1" {
  type = string
}

variable "db_subnet_2" {
  type = string
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "container_image" {
  type = string
  default = "bkimminich/juice-shop"
}

variable "health_check_path" {
  type = string
  default = "/"
}

variable "alb_tls_cert_arn" {
  type = string
  default = "arn:aws:acm:us-east-1:666781193487:certificate/1ebe4996-66b6-49f8-b77e-cdc0b67a4539"
}

########################################################################################################################
## Container Exposed Port
########################################################################################################################

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 3000
}

########################################################################################################################
## Cloudwatch
########################################################################################################################

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}

