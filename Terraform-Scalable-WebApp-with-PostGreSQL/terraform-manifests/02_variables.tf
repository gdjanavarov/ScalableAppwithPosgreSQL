variable "environment" {
  description = "Default Environment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "resource_location" {
  description = "Default location for all Azure resources"
  type        = string
}

# Networking variable declaration starts here
variable "VirtualNetwork" {
  description = "Virtual Network Name"
  type        = string
}
variable "VirtualNetwork_AddressSpace" {
  description = "Virtaul network Address space"
}

variable "subnet_prefix" {
  description = "Subnet Address Prefix"
  type        = list(any)
}

variable "App_Insights" {
  description = "App Insights Name"
  type        = string
}

variable "appservice_name" {
  description = "Azure App Service Name"
  type        = string
}

variable "app_service_plan_name" {
  description = "App Service Plan"
  type        = string

}

variable "azurerm_monitor_autoscale_setting" {
  description = "Auto Scale Settings Name"
  type        = string
}

# PostGreSQL DB variables
variable "Postgresql_Server" {
  description = "PostgreSql Server Name"
  type        = string
}
variable "Postgresql_DB" {
  description = "Postgresql Database Name"
  type        = string
}

# PostgreSQL DB Username (Variable Type: Sensitive String)
variable "db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
  sensitive   = true
}
# PostgreSQL DB Password (Variable Type: Sensitive String)
variable "db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  sensitive   = true
}

#Traffic Manager variables
variable "TrafficManager_Profile" {
  description = "Traffic Manager Profile Name"
  type        = string
}
variable "TrafficManager_Routing_Method" {
  description = "Traffic Manger Routing Method Name"
  type        = string
}
variable "TrafficManager_Endpoint" {
  description = "Traffic Manger Endpoint Name"
  type        = string
}
variable "TrafficManager_Endpoint_Type" {
  description = "Traffic Manger Endpoint Type"
  type        = string
}