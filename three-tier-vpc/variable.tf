variable "aws_region" {
  type        = list(string)
  default     = ["us-east-1", "us-west-1"]
  description = "description"
}

variable "subnets_cidr_block" {
  type        = list(string)
  default     = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24" "10.20.3.0/24" "10.20.4.0/24" "10.20.5.0/24" "10.20.6.0/24" "10.20.7.0/24" "10.20.8.0/24"]
  description = "description"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.20.0.0/20"
  description = "description"
}