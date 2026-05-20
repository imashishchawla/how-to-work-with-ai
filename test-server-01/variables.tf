variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH into the instances"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file (leave empty to skip key pair)"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Password for the demo database user"
  type        = string
  sensitive   = true
  default     = "changeme123"
}
