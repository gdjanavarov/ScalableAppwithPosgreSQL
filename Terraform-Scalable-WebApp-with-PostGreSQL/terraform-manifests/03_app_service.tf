
resource "azurerm_linux_web_app" "appservice" {
  name                = "${var.environment}-${var.appservice_name}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.appserviceplan1.id
  https_only          = true
  client_certificate_enabled = true
  client_certificate_mode = "Required"


  site_config {}

  app_settings = {
    "SOME_KEY" = "some-value"
    #  "APPINSIGHTS_JAVASCRIPT_ENABLED" = truey

    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appService-app_insights.instrumentation_key

    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"


    # Enable the following settings to map the app insights to the App service
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    # "XDT_MicrosoftApplicationInsights_Mode"= "recommended"
    # "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    # "DiagnosticServices_EXTENSION_VERSION" = "~3"
    # "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    # "SnapshotDebugger_EXTENSION_VERSION" = "~1"
    # "InstrumentationEngine_EXTENSION_VERSION" = "~1"
    #  "XDT_MicrosoftApplicationInsights_BaseExtensions" = "~1"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }


  depends_on = [
    azurerm_service_plan.appserviceplan1,
    azurerm_application_insights.appService-app_insights
  ]
}


# create the AppService Plan for the App Service hosting our website
resource "azurerm_service_plan" "appserviceplan1" {

  name                = "${var.environment}-${var.app_service_plan_name}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}


# Create the App Service Autoscale settings
resource "azurerm_monitor_autoscale_setting" "appserviceplan1_autoscale" {
  name                = "{var.environment}-{var.AppService1_AutoscaleSetting}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  target_resource_id  = azurerm_service_plan.appserviceplan1.id
  profile {
    name = "defaultProfile"

    capacity {
      default = 2
      minimum = 2
      maximum = 4
    }



    # Increase the Instance count by 1 when CPU usage is 85% consitanty for  5 mins
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.appserviceplan1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 85
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    # Decrease the Instance count by 1 when CPU usage is 40% or less consitanty for  5 mins
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.appserviceplan1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 40
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }


    # Increase the Instance count by 1 when Memory usage is 85% consitanty for  5 mins
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_service_plan.appserviceplan1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 85
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    # Decrease the Instance count by 1 when Memory usage is 40% or less consitanty for  5 mins
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_service_plan.appserviceplan1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 40
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

  }


}