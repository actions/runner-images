locals {
  tags = {
    DeptID                = "639513"                   # Required
    Environment           = var.environment            # Required
    BusinessOwner         = "john.knutson@hennepin.us" # Required
    FinancialBusinessUnit = "HNCTY"                    # Required
    Fund                  = "62"                       # Required
    WorkloadName          = "CIRunner"                 # Required
  }
}

# data "azurerm_subscription" "current" {}

#data "azurerm_client_config" "current" {}

# data "azurerm_resource_group" "monitoring" {
#   name = "Monitoring-rg"
# }

data "azurerm_resource_group" "rg" {
  name = "IT-Dev-CIRunner-rg"
}
# data "azurerm_resource_group" "diagnosticsrg" {
#   provider = azurerm.management
#   name     = "${var.dept}-AppDev-rg"
# }
# 
# data "azurerm_log_analytics_workspace" "diagnosticswkspace" {
#   provider            = azurerm.management
#   name                = "${var.dept}-AppDev-CentralUs-log"
#   resource_group_name = data.azurerm_resource_group.diagnosticsrg.name
# }

# resource "azurerm_resource_group" "rg" {
#   name     = "${var.dept}-${var.environment}${var.solution_name}-rg"
#   location = var.location
# 
#   #tags = local.tags
#   #tags = data.azurerm_subscription.current.tags
#   tags = contains(local.SharedSubscriptionNames, data.azurerm_subscription.current.display_name) || local.UseLocalTags == true ? local.tags : data.azurerm_subscription.current.tags
# }
# 
# resource "azurerm_role_assignment" "rg_reader_dev" {
#   scope                = azurerm_resource_group.rg.id
#   role_definition_name = "Reader"
#   principal_id         = local.devGroup.object_id
# }
