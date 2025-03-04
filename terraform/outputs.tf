# URL de la App Service para el microservicio de direcciones
output "address_service_url" {
  description = "URL de la App Service para el microservicio de direcciones"
  value       = azurerm_app_service.address_service.default_site_hostname
}

# URL de la App Service para el microservicio de órdenes
output "order_service_url" {
  description = "URL de la App Service para el microservicio de órdenes"
  value       = azurerm_app_service.order_service.default_site_hostname
}

# Nombre del grupo de recursos
output "resource_group_name" {
  description = "Nombre del grupo de recursos"
  value       = azurerm_resource_group.retry_pattern.name
}

# URL del Azure Container Registry (ACR)
output "acr_login_server" {
  description = "URL del Azure Container Registry"
  value       = azurerm_container_registry.retry_pattern.login_server
}
