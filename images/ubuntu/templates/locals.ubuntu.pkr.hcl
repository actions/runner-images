locals {
  image_properties_map = {
    "ubuntu22" = {
      source_image_marketplace_sku = "canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2"
      os_disk_size_gb              = 75
    },
    "ubuntu22-arm64" = {
      source_image_marketplace_sku = "canonical:0001-com-ubuntu-server-jammy:22_04-lts-arm64"
      os_disk_size_gb              = 75
    },
    "ubuntu24" = {
      source_image_marketplace_sku = "canonical:ubuntu-24_04-lts:server"
      os_disk_size_gb              = 75
      aws_source_ami_name_filter   = "ubuntu/images/*/ubuntu-noble-24.04-amd64-server-*"
    },
    "ubuntu24-arm64" = {
      source_image_marketplace_sku = "canonical:ubuntu-24_04-lts:server-arm64"
      os_disk_size_gb              = 75
    },
    "ubuntu26" = {
      source_image_marketplace_sku = "canonical:ubuntu-26_04-lts:server"
      os_disk_size_gb              = 75
      aws_source_ami_name_filter   = "ubuntu/images/*/ubuntu-resolute-26.04-amd64-server-*"
    },
    "ubuntu26-arm64" = {
      source_image_marketplace_sku = "canonical:ubuntu-26_04-lts:server-arm64"
      os_disk_size_gb              = 75
    }
  }

  source_image_marketplace_sku = local.image_properties_map[var.image_os].source_image_marketplace_sku
  os_disk_size_gb              = coalesce(var.os_disk_size_gb, local.image_properties_map[var.image_os].os_disk_size_gb)
  aws_source_ami_name_filter   = trimspace(var.aws_source_ami_name_filter) != "" ? var.aws_source_ami_name_filter : try(local.image_properties_map[var.image_os].aws_source_ami_name_filter, "")
  aws_ami_name                 = trimspace(var.aws_ami_name) != "" ? var.aws_ami_name : "runner-image-${var.image_os}-${var.image_version}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
}
