moved {
  from = data.azurerm_subscription.current
  to   = data.azurerm_subscription.this
}

moved {
  from = azurerm_consumption_budget_management_group.budget
  to   = azurerm_consumption_budget_management_group.this
}

moved {
  from = azurerm_consumption_budget_subscription.budget
  to   = azurerm_consumption_budget_subscription.this
}

moved {
  from = azurerm_consumption_budget_resource_group.budget
  to   = azurerm_consumption_budget_resource_group.this
}

moved {
  from = azurerm_cost_anomaly_alert.caa
  to   = azurerm_cost_anomaly_alert.this
}
