## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.metrics-server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_eks_certificate_authority"></a> [eks\_certificate\_authority](#input\_eks\_certificate\_authority) | n/a | `string` | n/a | yes |
| <a name="input_eks_endpoint"></a> [eks\_endpoint](#input\_eks\_endpoint) | n/a | `string` | n/a | yes |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | n/a | `string` | n/a | yes |

## Outputs

No outputs.