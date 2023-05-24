variable "cidr_block" {
  type        = string
  default     = "172.22.0.0/20"
  description = "description"
}

variable "subnet_cidr_block" {
  type        = list(string)
  default     = ["172.22.0.0/24", "172.22.1.0/24", "172.22.2.0/24", "172.22.3.0/24", "172.22.4.0/24", "172.22.5.0/24", "172.22.6.0/24", "172.22.7.0/24", "172.22.8.0/24", "172.22.9.0/24", "172.22.10.0/24"]
  description = "description"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "description"
}


