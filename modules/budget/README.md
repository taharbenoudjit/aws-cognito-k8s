## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | n/a | `string` | n/a | yes |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | n/a | `string` | n/a | yes |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_notification"></a> [notification](#input\_notification) | n/a | `any` | n/a | yes |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | n/a | `string` | n/a | yes |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | n/a | `string` | n/a | yes |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | n/a | `string` | n/a | yes |

## Outputs

No outputs.