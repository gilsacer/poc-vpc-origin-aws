# IAM Role and Instance Profile for SSM access
resource "aws_iam_role" "ssm_role" {
  name = "webserver-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "webserver-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

resource "tls_private_key" "webserver_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "webserver_key_pair" {
  key_name   = "webserver-key"
  public_key = tls_private_key.webserver_key.public_key_openssh
}

# Store private key in Secrets Manager
resource "aws_secretsmanager_secret" "webserver_private_key" {
  name        = "webserver-private-key"
  description = "Private key for EC2 instance"
}

resource "aws_secretsmanager_secret_version" "webserver_private_key_version" {
  secret_id     = aws_secretsmanager_secret.webserver_private_key.id
  secret_string = tls_private_key.webserver_key.private_key_pem
}

# EC2 instance WebServer
resource "aws_instance" "webserver" {
  ami                     = var.ec2-ami
  instance_type           = var.ec2-instance-type
  subnet_id               = aws_subnet.sub_private_app_1a.id
  vpc_security_group_ids  = [aws_security_group.web.id]
  iam_instance_profile    = aws_iam_instance_profile.ssm_profile.name
  key_name                = aws_key_pair.webserver_key_pair.key_name
  disable_api_termination = true


  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = false
    #kms_key_id            = var.ec2-kms-key

    tags = merge(
      local.tags,
      {
        Name = "${var.project_name}-EBS-root-WebServer"
      }
    )
  }

  /*   # Additional EBS volume
  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
    kms_key_id            = var.ec2-kms-key

    tags = merge(
      local.tags,
      {
        Name = "${var.project_name}-EBS-sdb-WebServer"
      }
    )
  } */

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-WebServer"
    }
  )
}
