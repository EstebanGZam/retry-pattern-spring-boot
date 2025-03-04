# Configura el proveedor de Azure
provider "azurerm" {
  features {}
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
resource "azurerm_app_service_plan" "retry_pattern" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Crea una App Service para el microservicio de direcciones
resource "azurerm_app_service" "address_service" {
  name                = var.address_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  app_service_plan_id = azurerm_app_service_plan.retry_pattern.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.retry_pattern.login_server}/address-service:latest"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "DOCKER_REGISTRY_SERVER_URL" = "https://${azurerm_container_registry.retry_pattern.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.retry_pattern.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.retry_pattern.admin_password
  }
}

# Crea una App Service para el microservicio de órdenes
resource "azurerm_app_service" "order_service" {
  name                = var.order_app_service_name
  location            = azurerm_resource_group.retry_pattern.location
  resource_group_name = azurerm_resource_group.retry_pattern.name
  app_service_plan_id = azurerm_app_service_plan.retry_pattern.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.retry_pattern.login_server}/order-service:latest"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "DOCKER_REGISTRY_SERVER_URL" = "https://${azurerm_container_registry.retry_pattern.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.retry_pattern.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.retry_pattern.admin_password
  }
}
