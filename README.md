# Project Overview

This project automates the provisioning and deployment of a cloud infrastructure that includes:
1. Amazon Cognito: For user authentication and identity management.
2. Kubernetes Cluster: A managed Kubernetes cluster with worker nodes, where the application is deployed.
3. Terraform: Handles the infrastructure as code, managing both the Kubernetes cluster and the integration with Cognito.

## Key Features
* Infrastructure Provisioning: Terraform provisions a fully managed Kubernetes cluster, including the necessary worker nodes, and sets up Amazon Cognito to handle user authentication.

* App Deployment: The application is automatically deployed within the Kubernetes cluster, ensuring high availability and scalability.

* Automatic Environment File Generation: One of the most interesting aspects of this setup is Terraform's ability to dynamically generate an .env file. This file contains the sensitive information and secrets related to the Amazon Cognito user pool, such as pool IDs and client secrets. These secrets are securely injected into the application running in the Kubernetes cluster, enabling seamless integration with Cognito for user authentication.

## Benifits
* Secure Configuration Management: Terraform handles the generation of environment variables, reducing the manual handling of sensitive information like Cognito secrets.

* Scalable and Manageable Infrastructure: The Kubernetes cluster provides a scalable environment for running applications, and with Cognito integrated, user authentication is easily managed.

# Terraform module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.52.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_budget"></a> [budget](#module\_budget) | ./modules/budget | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_cognito"></a> [cognito](#module\_cognito) | ./modules/cognito | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_eks_autoscalling"></a> [eks\_autoscalling](#module\_eks\_autoscalling) | ./modules/eks_autoscalling | n/a |
| <a name="module_internet_gateway"></a> [internet\_gateway](#module\_internet\_gateway) | ./modules/internet_gtw | n/a |
| <a name="module_kube_profile"></a> [kube\_profile](#module\_kube\_profile) | ./modules/kube_profile | n/a |
| <a name="module_kube_system_profile"></a> [kube\_system\_profile](#module\_kube\_system\_profile) | ./modules/kube_profile | n/a |
| <a name="module_logs_bucket"></a> [logs\_bucket](#module\_logs\_bucket) | ./modules/s3 | n/a |
| <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway) | ./modules/nat_gtw | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_groups | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |
| <a name="module_website_bucket"></a> [website\_bucket](#module\_website\_bucket) | ./modules/s3_website | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.eks_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.eks-fargate-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks-fargate-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.eks_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [local_file.env_app](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.env_build](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.kubectl_patch](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_kube_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [template_file.env_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget"></a> [budget](#input\_budget) | n/a | `any` | n/a | yes |
| <a name="input_cognito_users"></a> [cognito\_users](#input\_cognito\_users) | n/a | `any` | n/a | yes |
| <a name="input_eks"></a> [eks](#input\_eks) | n/a | `any` | n/a | yes |
| <a name="input_email_max_length"></a> [email\_max\_length](#input\_email\_max\_length) | n/a | `number` | n/a | yes |
| <a name="input_email_min_length"></a> [email\_min\_length](#input\_email\_min\_length) | n/a | `number` | n/a | yes |
| <a name="input_email_verification_message"></a> [email\_verification\_message](#input\_email\_verification\_message) | n/a | `string` | n/a | yes |
| <a name="input_email_verification_subject"></a> [email\_verification\_subject](#input\_email\_verification\_subject) | n/a | `string` | n/a | yes |
| <a name="input_internet_gtw"></a> [internet\_gtw](#input\_internet\_gtw) | n/a | `any` | n/a | yes |
| <a name="input_kube_profile"></a> [kube\_profile](#input\_kube\_profile) | n/a | `any` | n/a | yes |
| <a name="input_kube_system_profile"></a> [kube\_system\_profile](#input\_kube\_system\_profile) | n/a | `any` | n/a | yes |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | n/a | `string` | n/a | yes |
| <a name="input_logging_bucket_prefix"></a> [logging\_bucket\_prefix](#input\_logging\_bucket\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_logs_bucket_name"></a> [logs\_bucket\_name](#input\_logs\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | n/a | `any` | n/a | yes |
| <a name="input_pwd_minimum_length"></a> [pwd\_minimum\_length](#input\_pwd\_minimum\_length) | n/a | `string` | n/a | yes |
| <a name="input_pwd_require_lowercase"></a> [pwd\_require\_lowercase](#input\_pwd\_require\_lowercase) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_numbers"></a> [pwd\_require\_numbers](#input\_pwd\_require\_numbers) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_symbols"></a> [pwd\_require\_symbols](#input\_pwd\_require\_symbols) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_uppercase"></a> [pwd\_require\_uppercase](#input\_pwd\_require\_uppercase) | n/a | `bool` | n/a | yes |
| <a name="input_rds"></a> [rds](#input\_rds) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | n/a | `string` | n/a | yes |
| <a name="input_restrictions_list"></a> [restrictions\_list](#input\_restrictions\_list) | n/a | `list(string)` | n/a | yes |
| <a name="input_route53"></a> [route53](#input\_route53) | n/a | `any` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_user_cognito_name"></a> [user\_cognito\_name](#input\_user\_cognito\_name) | n/a | `string` | n/a | yes |
| <a name="input_user_pool_client"></a> [user\_pool\_client](#input\_user\_pool\_client) | n/a | `string` | n/a | yes |
| <a name="input_username_max_length"></a> [username\_max\_length](#input\_username\_max\_length) | n/a | `number` | n/a | yes |
| <a name="input_username_min_length"></a> [username\_min\_length](#input\_username\_min\_length) | n/a | `number` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_website_bucket_name"></a> [website\_bucket\_name](#input\_website\_bucket\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | n/a |
| <a name="output_user_pooli_client_id"></a> [user\_pooli\_client\_id](#output\_user\_pooli\_client\_id) | n/a |
