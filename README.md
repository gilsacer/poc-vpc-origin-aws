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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/internet_gateway) | resource |
| [aws_route_table.rt_private_app](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table) | resource |
| [aws_route_table_association.rtb_assoc_priv_1a](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rtb_assoc_priv_1b](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/route_table_association) | resource |
| [aws_subnet.sub_private_app_1a](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/subnet) | resource |
| [aws_subnet.sub_private_app_1b](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/subnet) | resource |
| [aws_vpc.vpc-basic](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.97.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | n/a | `string` | `"10.11.0.0/16"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"VPC-Origin"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->