# URL de la App Service para el microservicio de direcciones
output "address_service_url" {
  description = "URL de la App Service para el microservicio de direcciones"
  value       = azurerm_linux_web_app.address_service.default_hostname
}

# URL de la App Service para el microservicio de órdenes
output "order_service_url" {
  description = "URL de la App Service para el microservicio de órdenes"
  value       = azurerm_linux_web_app.order_service.default_hostname
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
