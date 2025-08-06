variable "project_name" {
  type        = string
  description = ""
  default     = "VPC-Origin"
}
variable "cidr_block" {
  type        = string
  description = ""
  default     = "10.11.0.0/16"
}
variable "ec2-instance-type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2-ami" {
  description = "Canonical, Ubuntu, 24.04, amd64 noble image"
  type        = string
  default     = "ami-020cba7c55df1f615"
}