# Security group for the ALB
resource "aws_security_group" "alb_sg" {
  name        = "SG-alb-webserver"
  description = "Security group for ALB WebServer"
  vpc_id      = aws_vpc.vpc-basic.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
    description     = "Allow HTTP traffic"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
    description     = "Allow HTTPS traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.11.0.0/16"]
    description = "Allow outbound traffic to VPC CIDR"
  }

  tags = merge(local.tags, { Name = "SG ALB" })
}