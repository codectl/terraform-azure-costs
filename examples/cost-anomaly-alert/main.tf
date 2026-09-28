module "costs" {
  source  = "cloudnationhq/costs/azure"
  version = "~> 2.0"

  costs = {
    cost_anomaly_alerts = {
      caa1 = {
        name            = "caa-alert"
        display_name    = "My Test Anomaly Alert"
        email_subject   = "Anomaly Detected"
        email_addresses = ["email@demo-mag-email.nl"]
        message         = "Anomaly detected in your Azure subscription"
      }
    }
  }
}
