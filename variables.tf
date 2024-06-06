variable "profile" {
  description = "AWS profile used"
  type        = string
  default     = "ppavlov"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

########################################################################################################################
## Tagging the Resources
########################################################################################################################

variable  "name" {
  description = "Service name of the Project"
  type        = string
  default     = "ecs"
}

variable "owner" {
  description = "Who is the Owner of the  deploymend"
  type        = string
  default     = "Pavlov"
}

variable "environment" {
  description = "What Environment is deployed"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "What Project is the deployment for"
  type        = string
  default     = "ecs-tasks"
}

variable "department" {
  description = "What Department is deployment related to"
  type        = string
  default     = "IT"
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
