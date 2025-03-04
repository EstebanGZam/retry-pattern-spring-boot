# Ubicación de los recursos en Azure
variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "East US"
}

# Nombre del grupo de recursos
variable "resource_group_name" {
  description = "Nombre del grupo de recursos en Azure"
  type        = string
  default     = "retry-pattern-resources"
}

# Nombre del Azure Container Registry (ACR)
variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
  default     = "retry-pattern-acr"
}

# Nombre del plan de App Service
variable "app_service_plan_name" {
  description = "Nombre del plan de App Service"
  type        = string
  default     = "retry-pattern-appserviceplan"
}

# Nombre de la App Service para el microservicio de direcciones
variable "address_app_service_name" {
  description = "Nombre de la App Service para el microservicio de direcciones"
  type        = string
  default     = "retry-pattern-address-service"
}

# Nombre de la App Service para el microservicio de órdenes
variable "order_app_service_name" {
  description = "Nombre de la App Service para el microservicio de órdenes"
  type        = string
  default     = "retry-pattern-order-service"
}
