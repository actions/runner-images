variable "app_name" {
  default = "agentpool"
}

variable "location" {
  default = "westeurope"
}

variable "self_hosted_image_publisher" {
  default = "Azureway"
}

variable "self_hosted_image_offer" {
  default = "GitHubActionsRunner"
}

variable "self_hosted_image_sku" {
  default = "Free"
}

variable "image_version" {
  description = "Version of the published image"
}

variable "image_type" {
  description = "Image namge for publishing"
}

variable "image_type_version" {
  
}

variable "short_image_name" {
  
}

variable "subscription-id" {
  description = "Subscription for service principal"
}

variable "spn-client-id" {
  description = "Client ID of the service principal"
}

variable "spn-client-secret" {
  description = "Secret for service principal"
}

variable "spn-tenant-id" {
  description = "Tenant ID for service principal"
}
