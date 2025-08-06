# poc-vpc-origin-aws
poc vpc origin + CloudFront + webserver

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.97.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.97.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm_profile](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.webserver](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/instance) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/internet_gateway) | resource |
| [aws_key_pair.webserver_key_pair](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/key_pair) | resource |
| [aws_route_table.rt_private_app](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table) | resource |
| [aws_route_table_association.rtb_assoc_priv_1a](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rtb_assoc_priv_1b](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table_association) | resource |
| [aws_secretsmanager_secret.webserver_private_key](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.webserver_private_key_version](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.web](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/security_group) | resource |
| [aws_subnet.sub_private_app_1a](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/subnet) | resource |
| [aws_subnet.sub_private_app_1b](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/subnet) | resource |
| [aws_vpc.vpc-basic](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/vpc) | resource |
| [tls_private_key.webserver_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | n/a | `string` | `"10.11.0.0/16"` | no |
| <a name="input_ec2-ami"></a> [ec2-ami](#input\_ec2-ami) | Canonical, Ubuntu, 24.04, amd64 noble image | `string` | `"ami-020cba7c55df1f615"` | no |
| <a name="input_ec2-instance-type"></a> [ec2-instance-type](#input\_ec2-instance-type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"VPC-Origin"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->