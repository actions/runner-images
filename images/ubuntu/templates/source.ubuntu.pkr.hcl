source "azure-arm" "image" {
  client_cert_path   = var.client_cert_path
  client_id          = var.client_id
  client_jwt         = var.client_jwt
  client_secret      = var.client_secret
  object_id          = var.object_id
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url
  subscription_id    = var.subscription_id
  tenant_id          = var.tenant_id
  use_azure_cli_auth = var.use_azure_cli_auth

  allowed_inbound_ip_addresses           = var.allowed_inbound_ip_addresses
  build_resource_group_name              = var.build_resource_group_name
  image_publisher                        = split(":", local.source_image_marketplace_sku)[0]
  image_offer                            = split(":", local.source_image_marketplace_sku)[1]
  image_sku                              = split(":", local.source_image_marketplace_sku)[2]
  image_version                          = var.source_image_version
  location                               = var.location
  managed_image_name                     = var.managed_image_name
  managed_image_resource_group_name      = var.managed_image_resource_group_name
  managed_image_storage_account_type     = var.managed_image_storage_account_type
  os_disk_size_gb                        = local.os_disk_size_gb
  os_type                                = var.image_os_type
  private_virtual_network_with_public_ip = var.private_virtual_network_with_public_ip
  ssh_clear_authorized_keys              = var.ssh_clear_authorized_keys
  temp_resource_group_name               = var.temp_resource_group_name
  virtual_network_name                   = var.virtual_network_name
  virtual_network_resource_group_name    = var.virtual_network_resource_group_name
  virtual_network_subnet_name            = var.virtual_network_subnet_name
  vm_size                                = var.vm_size
  winrm_username                         = var.winrm_username

  shared_image_gallery_destination {
    subscription         = var.subscription_id
    gallery_name         = var.gallery_name
    resource_group       = var.gallery_resource_group_name
    image_name           = var.gallery_image_name
    image_version        = var.gallery_image_version
    storage_account_type = var.gallery_storage_account_type
  }

  dynamic "azure_tag" {
    for_each = var.azure_tags
    content {
      name  = azure_tag.key
      value = azure_tag.value
    }
  }
}

source "amazon-ebs" "image" {
  ami_name                    = local.aws_ami_name
  associate_public_ip_address = true
  encrypt_boot                = false
  instance_type               = var.aws_instance_type
  region                      = var.aws_region
  ssh_interface               = "public_ip"
  ssh_username                = var.aws_ssh_username

  aws_polling {
    delay_seconds = 15
    max_attempts  = 900
  }

  source_ami_filter {
    filters = {
      architecture     = "x86_64"
      name             = local.aws_source_ami_name_filter
      root-device-type = "ebs"
    }

    most_recent = true
    owners      = [var.aws_source_ami_owner]
  }

  ami_description = "Runner image for ${var.image_os} built from runner-images templates"

  tags = merge(
    {
      Name         = local.aws_ami_name
      ImageOS      = var.image_os
      ImageVersion = var.image_version
    },
    var.aws_ami_tags
  )

  run_tags = {
    owner      = "runner-images-build"
    created_by = "packer"
  }

  dynamic "launch_block_device_mappings" {
    for_each = local.os_disk_size_gb > 0 ? [1] : []
    content {
      device_name           = "/dev/sda1"
      volume_size           = local.os_disk_size_gb
      volume_type           = "gp3"
      encrypted             = false
      delete_on_termination = true
    }
  }

  vpc_id = var.aws_vpc_id != "" ? var.aws_vpc_id : null

  subnet_id = var.aws_subnet_id != "" ? var.aws_subnet_id : null

  security_group_id = var.aws_security_group_id != "" ? var.aws_security_group_id : null
}
