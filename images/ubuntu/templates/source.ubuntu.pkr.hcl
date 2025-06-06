source "azure-arm" "image" {
  client_cert_path                       = var.client_cert_path
  client_id                              = var.client_id
  client_secret                          = var.client_secret
  object_id                              = var.object_id
  oidc_request_token                     = var.oidc_request_token
  oidc_request_url                       = var.oidc_request_url
  subscription_id                        = var.subscription_id
  tenant_id                              = var.tenant_id
  use_azure_cli_auth                     = var.use_azure_cli_auth

  allowed_inbound_ip_addresses           = var.allowed_inbound_ip_addresses
  build_resource_group_name              = var.build_resource_group_name
  image_offer                            = local.image_properties.offer
  image_publisher                        = local.image_properties.publisher
  image_sku                              = local.image_properties.sku
  image_version                          = var.source_image_version
  location                               = var.location
  managed_image_name                     = var.managed_image_name
  managed_image_resource_group_name      = var.managed_image_resource_group_name
  managed_image_storage_account_type     = var.managed_image_storage_account_type
  os_disk_size_gb                        = local.image_properties.os_disk_size_gb
  os_type                                = var.image_os_type
  private_virtual_network_with_public_ip = var.private_virtual_network_with_public_ip
  temp_resource_group_name               = var.temp_resource_group_name
  virtual_network_name                   = var.virtual_network_name
  virtual_network_resource_group_name    = var.virtual_network_resource_group_name
  virtual_network_subnet_name            = var.virtual_network_subnet_name
  vm_size                                = var.vm_size
  winrm_username                         = var.winrm_username

  shared_image_gallery_destination {
    subscription                         = var.subscription_id
    gallery_name                         = var.gallery_name
    resource_group                       = var.gallery_resource_group_name
    image_name                           = var.gallery_image_name
    image_version                        = var.gallery_image_version
    storage_account_type                 = var.gallery_storage_account_type
  }

  dynamic "azure_tag" {
    for_each = var.azure_tags
    content {
      name  = azure_tag.key
      value = azure_tag.value
    }
  }
}
