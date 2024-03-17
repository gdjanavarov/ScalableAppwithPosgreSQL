environment = "dev"

resource_group_name = "rg"
resource_location   = "eastus"

# VNET variable assignments
VirtualNetwork              = "vnet"
VirtualNetwork_AddressSpace = ["10.0.0.0/23"] # 512 addresses

#Subnet Address prefixes
subnet_prefix = ["10.0.1.0/24", "10.0.0.0/24"]

App_Insights                      = "appi-1"
appservice_name                   = "app-1"
app_service_plan_name             = "plan"
azurerm_monitor_autoscale_setting = "AppService1_AutoscaleSetting"

#PostGreSQL variable assignment starts here
Postgresql_Server = "postgresql"
Postgresql_DB     = "teva"

# Traffic Manager variable assignment starts here
TrafficManager_Profile        = "tevatraf1"
TrafficManager_Endpoint       = "tevatraf-ep1"
TrafficManager_Routing_Method = "Weighted"
TrafficManager_Endpoint_Type  = "azureEndpoints"