
resource "aws_subnet" "sub_private_app_1a" {
  vpc_id            = aws_vpc.vpc-basic.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-Sub-Private-APP-1a"
    }
  )
}

resource "aws_subnet" "sub_private_app_1b" {
  vpc_id            = aws_vpc.vpc-basic.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-Sub-Private-APP-1b"
    }
  )
}

resource "aws_route_table" "rt_private_app" {
  vpc_id = aws_vpc.vpc-basic.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-RT-Private-APP"
    }
  )
}

resource "aws_route_table_association" "rtb_assoc_priv_1a" {
  subnet_id      = aws_subnet.sub_private_app_1a.id
  route_table_id = aws_route_table.rt_private_app.id
}
resource "aws_route_table_association" "rtb_assoc_priv_1b" {
  subnet_id      = aws_subnet.sub_private_app_1b.id
  route_table_id = aws_route_table.rt_private_app.id
}