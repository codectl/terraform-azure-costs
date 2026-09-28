output "consumption_budget_management_group" {
  description = "contains all consumption budget management group configuration"
  value       = azurerm_consumption_budget_management_group.this
}

output "consumption_budget_subscription" {
  description = "contains all consumption budget subscription configuration"
  value       = azurerm_consumption_budget_subscription.this
}

output "consumption_budget_resource_group" {
  description = "contains all consumption budget resource group configuration"
  value       = azurerm_consumption_budget_resource_group.this
}

output "cost_anomaly_alert" {
  description = "contains all cost anomaly alert configuration"
  value       = azurerm_cost_anomaly_alert.this
}