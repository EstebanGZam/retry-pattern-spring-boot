# URL of the App Service for the address microservice
output "address_service_url" {
  description = "URL of the App Service for the address microservice"
  value       = azurerm_linux_web_app.address_service.default_hostname
}

# URL of the App Service for the order microservice
output "order_service_url" {
  description = "URL of the App Service for the order microservice"
  value       = azurerm_linux_web_app.order_service.default_hostname
}

# Name of the resource group
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.retry_pattern.name
}