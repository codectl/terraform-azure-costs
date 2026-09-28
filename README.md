# Costs

This terraform module streamlines the creation of multiple resources related to consumption and costs.

## Features

Configure budget alerts for management groups

Set up consumption monitoring for subscriptions

Establish spending thresholds for resource groups

Deploy cost anomaly detection alerts

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9.3)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 5.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (5.5.0)

## Resources

The following resources are used by this module:

- [azurerm_consumption_budget_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) (resource)
- [azurerm_consumption_budget_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) (resource)
- [azurerm_consumption_budget_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) (resource)
- [azurerm_cost_anomaly_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cost_anomaly_alert) (resource)
- [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_costs"></a> [costs](#input\_costs)

Description: configuration for consumption budgets and cost anomaly alerts

Type:

```hcl
object({
    consumption_budget_management_groups = optional(map(object({
      name                = optional(string)
      management_group_id = string
      amount              = number
      time_grain          = optional(string)
      etag                = optional(string)
      time_period = optional(object({
        start_date = string
        end_date   = optional(string)
      }))
      notifications = optional(map(object({
        operator       = string
        threshold      = number
        threshold_type = optional(string)
        contact_emails = list(string)
        enabled        = optional(bool)
      })), {})
      filter = optional(object({
        dimensions = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
        tags = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
      }))
    })), {})
    consumption_budget_subscriptions = optional(map(object({
      name       = optional(string)
      amount     = number
      time_grain = optional(string)
      etag       = optional(string)
      time_period = object({
        start_date = string
        end_date   = optional(string)
      })
      notifications = map(object({
        operator       = string
        threshold      = number
        threshold_type = optional(string)
        contact_emails = optional(list(string), [])
        contact_groups = optional(list(string), [])
        contact_roles  = optional(list(string), [])
        enabled        = optional(bool)
      }))
      filter = optional(object({
        dimensions = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
        tags = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
      }))
    })), {})
    consumption_budget_resource_groups = optional(map(object({
      name              = optional(string)
      resource_group_id = string
      amount            = number
      time_grain        = optional(string)
      etag              = optional(string)
      time_period = optional(object({
        start_date = string
        end_date   = optional(string)
      }))
      notifications = optional(map(object({
        operator       = string
        threshold      = number
        threshold_type = optional(string)
        contact_emails = optional(list(string), [])
        contact_groups = optional(list(string), [])
        contact_roles  = optional(list(string), [])
        enabled        = optional(bool)
      })), {})
      filter = optional(object({
        dimensions = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
        tags = optional(map(object({
          name     = string
          operator = optional(string)
          values   = list(string)
        })), {})
      }))
    })), {})
    cost_anomaly_alerts = optional(map(object({
      name               = optional(string)
      display_name       = string
      subscription_id    = optional(string)
      email_addresses    = list(string)
      email_subject      = string
      message            = optional(string, "Anomaly detected in your Azure subscription")
      notification_email = optional(string)
    })), {})
  })
```

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_consumption_budget_management_group"></a> [consumption\_budget\_management\_group](#output\_consumption\_budget\_management\_group)

Description: contains all consumption budget management group configuration

### <a name="output_consumption_budget_resource_group"></a> [consumption\_budget\_resource\_group](#output\_consumption\_budget\_resource\_group)

Description: contains all consumption budget resource group configuration

### <a name="output_consumption_budget_subscription"></a> [consumption\_budget\_subscription](#output\_consumption\_budget\_subscription)

Description: contains all consumption budget subscription configuration

### <a name="output_cost_anomaly_alert"></a> [cost\_anomaly\_alert](#output\_cost\_anomaly\_alert)

Description: contains all cost anomaly alert configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md).

## License

MIT Licensed. See [LICENSE](https://github.com/cloudnationhq/terraform-azure-costs/blob/main/LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/)
