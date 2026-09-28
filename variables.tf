variable "costs" {
  description = "configuration for consumption budgets and cost anomaly alerts"
  type = object({
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
}
