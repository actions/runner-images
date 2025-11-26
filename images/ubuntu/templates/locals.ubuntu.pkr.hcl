locals {
  image_properties_map = {
      "ubuntu22" = {
            source_image_marketplace_sku = "canonical:0001-com-ubuntu-server-jammy:22_04-lts"
            os_disk_size_gb = 75
      },
      "ubuntu24" = {
            source_image_marketplace_sku = "canonical:ubuntu-24_04-lts:server-gen1"
            os_disk_size_gb = 75
      }
  }

  source_image_marketplace_sku = local.image_properties_map[var.image_os].source_image_marketplace_sku
  os_disk_size_gb = coalesce(var.os_disk_size_gb, local.image_properties_map[var.image_os].os_disk_size_gb)
}
