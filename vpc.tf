resource "aws_vpc" "vpc-basic" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-VPC"
    }
  )
}

#################### IGW ##############################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-basic.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-IGW"
    }
  )
}