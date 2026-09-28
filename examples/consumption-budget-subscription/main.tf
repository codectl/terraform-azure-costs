module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.32"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "mag" {
  source  = "cloudnationhq/mag/azure"
  version = "~> 4.0"

  groups = {
    demo = {
      name                = "mag-demo-dev-email"
      resource_group_name = module.rg.groups.demo.name
      location            = "global"
      short_name          = "mag-email"

      email_receiver = {
        email1 = {
          name          = "send to demo"
          email_address = "email@demo-mag-email.nl"
        }
      }
    }
  }
}

module "costs" {
  source  = "cloudnationhq/costs/azure"
  version = "~> 2.0"

  costs = {
    consumption_budget_subscriptions = {
      cbs1 = {
        name       = "cbs1"
        amount     = 100
        time_grain = "Monthly"
        time_period = {
          start_date = formatdate("YYYY-MM-01'T'00:00:00'Z'", timestamp())
          end_date   = formatdate("YYYY-MM-01'T'00:00:00'Z'", timeadd(timestamp(), "1440h"))
        }

        filter = {
          dimensions = {
            dimension1 = {
              name     = "ResourceGroupName"
              operator = "In"
              values = [
                module.rg.groups.demo.name,
              ]
            }
          }

          tags = {
            tag1 = {
              name     = "foo"
              operator = "In"
              values = [
                "bar",
                "baz",
              ]
            }
          }
        }

        notifications = {
          notification1 = {
            operator       = "EqualTo"
            threshold      = 90.0
            contact_groups = [module.mag.groups.demo.id]
            contact_roles  = ["Owner"]
            enabled        = true
          }

          notification2 = {
            enabled        = false
            operator       = "GreaterThan"
            threshold      = 100.0
            threshold_type = "Forecasted"
            contact_emails = ["email@demo-mag-email.nl"]
          }
        }
      }
    }
  }
}
