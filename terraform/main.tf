provider "azurerm" {
  features {}
  subscription_id = ""
}

# Crea un grupo de recursos en Azure
resource "azurerm_resource_group" "retry_pattern" {
  name     = var.resource_group_name
  location = var.location
}

# Crea un Azure Container Registry (ACR) para almacenar las imágenes Docker
resource "azurerm_container_registry" "retry_pattern" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.retry_pattern.name
  location            = azurerm_resource_group.retry_pattern.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Crea un plan de App Service para los microservicios
resource "azurerm_service_plan" "retry_pattern" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Crea una App Service para el microservicio de direcciones
resource "azurerm_linux_web_app" "address_service" {
  name                = var.address_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  service_plan_id     = azurerm_service_plan.retry_pattern.id

  site_config {
    application_stack {
      docker_image_name   = "${azurerm_container_registry.retry_pattern.login_server}/address-service:latest"
    }
  }

  auth_settings {
    enabled = true
    active_directory {
      client_id     = ""
      client_secret = ""
      allowed_audiences = ["https://${azurerm_container_registry.retry_pattern.login_server}"]
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

# Crea una App Service para el microservicio de órdenes
resource "azurerm_linux_web_app" "order_service" {
  name                = var.order_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  service_plan_id     = azurerm_service_plan.retry_pattern.id

  site_config {
    application_stack {
      docker_image_name   = "${azurerm_container_registry.retry_pattern.login_server}/order-service:latest"
    }
  }

  auth_settings {
    enabled = true
    active_directory {
      client_id     = ""
      client_secret = ""
      allowed_audiences = ["https://${azurerm_container_registry.retry_pattern.login_server}"]
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
