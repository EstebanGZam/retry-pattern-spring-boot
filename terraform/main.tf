provider "azurerm" {
  features {}
  subscription_id = "2f04ea2a-6146-4799-984c-d5f971c91b16"
}

# Create a resource group in Azure
resource "azurerm_resource_group" "retry_pattern" {
  name     = var.resource_group_name
  location = var.location
}

# Create an App Service plan for the microservices
resource "azurerm_service_plan" "retry_pattern" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create an App Service for the address microservice
resource "azurerm_linux_web_app" "address_service" {
  name                = var.address_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  service_plan_id     = azurerm_service_plan.retry_pattern.id

  site_config {
    application_stack {
      java_version = "17"       # Java version
      java_server = "JAVA"     # Standalone Spring Boot application
      java_server_version = "17"       # Same version as java_version
    }
  }

  auth_settings {
    enabled = true
    active_directory {
      client_id     = "fa4ab745-1592-41cf-ac6d-31e20e9d221b"
      client_secret = ""
      allowed_audiences = ["https://retry-pattern-address-service-esteban.azurewebsites.net"]
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "WEBSITES_PORT" = "9090"  # Port on which your Spring Boot application listens
    "JAVA_OPTS"                = "-Dserver.port=9090"
    "SPRING_PROFILES_ACTIVE"   = "production"
  }
}

# Create an App Service for the order microservice
resource "azurerm_linux_web_app" "order_service" {
  name                = var.order_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  service_plan_id     = azurerm_service_plan.retry_pattern.id

  site_config {
    application_stack {
      java_version = "17"       # Java version
      java_server = "JAVA"     # Standalone Spring Boot application
      java_server_version = "17"       # Same version as java_version
    }
  }

  auth_settings {
    enabled = true
    active_directory {
      client_id     = "fa4ab745-1592-41cf-ac6d-31e20e9d221b"
      client_secret = ""
      allowed_audiences = ["https://retry-pattern-order-service-esteban.azurewebsites.net"]
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "WEBSITES_PORT" = "8081"  # Port on which your Spring Boot application listens
    "JAVA_OPTS"                = "-Dserver.port=8081"
    "SPRING_PROFILES_ACTIVE"   = "production"

  }
}