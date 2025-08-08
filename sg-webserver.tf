resource "aws_security_group" "web" {
  name        = "Web"
  description = "Allow public inbound traffic"
  vpc_id      = aws_vpc.vpc-basic.id

  ingress {
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 # https
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.11.0.0/16"]
  }

  tags = merge(local.tags, { Name = "SG WebServer" })
}