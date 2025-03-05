# Location of the resources in Azure
variable "location" {
  description = "Azure region where the resources will be deployed"
  type        = string
  default     = "East US"
}

# Name of the resource group
variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
  default     = "retry-pattern-resources-esteban"
}

# Name of the App Service plan
variable "app_service_plan_name" {
  description = "Name of the App Service plan"
  type        = string
  default     = "retry-pattern-appserviceplan-esteban"
}

# Name of the App Service for the address microservice
variable "address_app_service_name" {
  description = "Name of the App Service for the address microservice"
  type        = string
  default     = "retry-pattern-address-service-esteban"
}

# Name of the App Service for the order microservice
variable "order_app_service_name" {
  description = "Name of the App Service for the order microservice"
  type        = string
  default     = "retry-pattern-order-service-esteban"
}