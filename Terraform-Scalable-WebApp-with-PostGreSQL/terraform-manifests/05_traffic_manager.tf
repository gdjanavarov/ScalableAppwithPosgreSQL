# Create random numbers  for DNS config and Traffic manager name
resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}


# Create the Traffice Manager profile
resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name                   = "${var.environment}-${var.TrafficManager_Profile}"
  resource_group_name    = azurerm_resource_group.resource_group.name
  traffic_routing_method = var.TrafficManager_Routing_Method

  # Setup the cname record in the DNS server so that DNS record is mapped to the Trafficmanger url
  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }
  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}