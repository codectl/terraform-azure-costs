module "naming" {
  source  = "codectl/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "regions" {
  source  = "codectl/locations/azure"
  version = "~> 1.0"

  location = {
    primary = "westeurope"
  }
}

module "rg" {
  source  = "codectl/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = module.regions.location.primary.name
    }
  }
}

module "mag" {
  source  = "codectl/mag/azure"
  version = "~> 1.0"

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
  source  = "codectl/costs/azure"
  version = "~> 1.0"

  costs = {
    consumption_budget_resource_groups = {
      cbrg1 = {
        name              = "cbrg1"
        resource_group_id = module.rg.groups.demo.id
        amount            = 1000
        time_grain        = "Monthly"
        time_period = {
          # "2026-01-01T00:00:00Z" format
          start_date = formatdate("YYYY-MM-01'T'00:00:00'Z'", timestamp())
          end_date   = formatdate("YYYY-MM-01'T'00:00:00'Z'", timeadd(timestamp(), "1440h"))
        }

        filter = {
          dimensions = {
            dimension1 = {
              name     = "ResourceId"
              operator = "In"
              values = [
                module.mag.groups.demo.id,
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
            threshold_type = "Forecasted"
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
