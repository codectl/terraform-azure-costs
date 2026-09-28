data "azurerm_subscription" "this" {}

# consumption budget management group
resource "azurerm_consumption_budget_management_group" "this" {
  for_each = var.costs.consumption_budget_management_groups

  name = coalesce(
    each.value.name, each.key
  )

  management_group_id = each.value.management_group_id
  amount              = each.value.amount
  time_grain          = each.value.time_grain
  etag                = each.value.etag

  dynamic "time_period" {
    for_each = each.value.time_period != null ? { "this" = each.value.time_period } : {}

    content {
      start_date = time_period.value.start_date
      end_date   = time_period.value.end_date
    }
  }

  dynamic "notification" {
    for_each = each.value.notifications

    content {
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      contact_emails = notification.value.contact_emails
      enabled        = notification.value.enabled
    }
  }

  dynamic "filter" {
    for_each = each.value.filter != null ? { "this" = each.value.filter } : {}

    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions

        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }

      dynamic "tag" {
        for_each = filter.value.tags

        content {
          name     = tag.value.name
          operator = tag.value.operator
          values   = tag.value.values
        }
      }
    }
  }
}

# consumption budget subscriptions
resource "azurerm_consumption_budget_subscription" "this" {
  for_each = var.costs.consumption_budget_subscriptions

  name = coalesce(
    each.value.name, each.key
  )

  subscription_id = data.azurerm_subscription.this.id
  amount          = each.value.amount
  time_grain      = each.value.time_grain
  etag            = each.value.etag

  time_period {
    start_date = each.value.time_period.start_date
    end_date   = each.value.time_period.end_date
  }

  dynamic "notification" {
    for_each = each.value.notifications

    content {
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
      enabled        = notification.value.enabled
    }
  }

  dynamic "filter" {
    for_each = each.value.filter != null ? { "this" = each.value.filter } : {}

    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions

        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }

      dynamic "tag" {
        for_each = filter.value.tags

        content {
          name     = tag.value.name
          operator = tag.value.operator
          values   = tag.value.values
        }
      }
    }
  }
}

# consumption budget resource groups
resource "azurerm_consumption_budget_resource_group" "this" {
  for_each = var.costs.consumption_budget_resource_groups

  name = coalesce(
    each.value.name, each.key
  )

  resource_group_id = each.value.resource_group_id
  amount            = each.value.amount
  time_grain        = each.value.time_grain
  etag              = each.value.etag

  dynamic "time_period" {
    for_each = each.value.time_period != null ? { "this" = each.value.time_period } : {}

    content {
      start_date = time_period.value.start_date
      end_date   = time_period.value.end_date
    }
  }

  dynamic "notification" {
    for_each = each.value.notifications

    content {
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
      enabled        = notification.value.enabled
    }
  }

  dynamic "filter" {
    for_each = each.value.filter != null ? { "this" = each.value.filter } : {}

    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions

        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }

      dynamic "tag" {
        for_each = filter.value.tags

        content {
          name     = tag.value.name
          operator = tag.value.operator
          values   = tag.value.values
        }
      }
    }
  }
}

# cost anomaly alerts
resource "azurerm_cost_anomaly_alert" "this" {
  for_each = var.costs.cost_anomaly_alerts

  name = coalesce(
    each.value.name, each.key
  )

  subscription_id = coalesce(
    each.value.subscription_id, data.azurerm_subscription.this.id
  )

  display_name       = each.value.display_name
  email_addresses    = each.value.email_addresses
  email_subject      = each.value.email_subject
  message            = each.value.message
  notification_email = each.value.notification_email
}
