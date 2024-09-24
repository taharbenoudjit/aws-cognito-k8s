## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.user_pool_client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [null_resource.register_user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.validate_user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cognito_users"></a> [cognito\_users](#input\_cognito\_users) | n/a | `any` | n/a | yes |
| <a name="input_email_max_length"></a> [email\_max\_length](#input\_email\_max\_length) | n/a | `number` | n/a | yes |
| <a name="input_email_min_length"></a> [email\_min\_length](#input\_email\_min\_length) | n/a | `number` | n/a | yes |
| <a name="input_email_verification_message"></a> [email\_verification\_message](#input\_email\_verification\_message) | n/a | `string` | n/a | yes |
| <a name="input_email_verification_subject"></a> [email\_verification\_subject](#input\_email\_verification\_subject) | n/a | `string` | n/a | yes |
| <a name="input_pwd_minimum_length"></a> [pwd\_minimum\_length](#input\_pwd\_minimum\_length) | n/a | `string` | n/a | yes |
| <a name="input_pwd_require_lowercase"></a> [pwd\_require\_lowercase](#input\_pwd\_require\_lowercase) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_numbers"></a> [pwd\_require\_numbers](#input\_pwd\_require\_numbers) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_symbols"></a> [pwd\_require\_symbols](#input\_pwd\_require\_symbols) | n/a | `bool` | n/a | yes |
| <a name="input_pwd_require_uppercase"></a> [pwd\_require\_uppercase](#input\_pwd\_require\_uppercase) | n/a | `bool` | n/a | yes |
| <a name="input_user_cognito_name"></a> [user\_cognito\_name](#input\_user\_cognito\_name) | n/a | `string` | n/a | yes |
| <a name="input_user_pool_client"></a> [user\_pool\_client](#input\_user\_pool\_client) | n/a | `string` | n/a | yes |
| <a name="input_username_max_length"></a> [username\_max\_length](#input\_username\_max\_length) | n/a | `number` | n/a | yes |
| <a name="input_username_min_length"></a> [username\_min\_length](#input\_username\_min\_length) | n/a | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | n/a |
| <a name="output_user_pooli_client_id"></a> [user\_pooli\_client\_id](#output\_user\_pooli\_client\_id) | n/a |
