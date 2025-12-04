locals {
    image_properties_map = {
      "win19" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter"
            os_disk_size_gb = 256
      },
      "win22" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2022-Datacenter"
            os_disk_size_gb = 256
      },
      "win25" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2025-Datacenter"
            os_disk_size_gb = 150
      }
  }

  source_image_marketplace_sku = local.image_properties_map[var.image_os].source_image_marketplace_sku
  os_disk_size_gb = coalesce(var.os_disk_size_gb, local.image_properties_map[var.image_os].os_disk_size_gb)
}
