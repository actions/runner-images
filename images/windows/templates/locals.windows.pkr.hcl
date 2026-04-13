locals {
    image_properties_map = {
      "win22" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2022-Datacenter-g2"
            os_disk_size_gb = 256
      },
      "win25" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2025-Datacenter-g2"
            os_disk_size_gb = 150
      },
      "win25-vs2026" = {
            source_image_marketplace_sku = "MicrosoftWindowsServer:WindowsServer:2025-Datacenter-g2"
            os_disk_size_gb = 150
      },
      "win11-arm64" = {
            source_image_marketplace_sku = "microsoftwindowsdesktop:windows11preview-arm64:win11-25h2-ent"
            os_disk_size_gb = 256
      },
      "win11-vs2026-arm64" = {
            source_image_marketplace_sku = "microsoftwindowsdesktop:windows11preview-arm64:win11-25h2-ent"
            os_disk_size_gb = 256
      }
  }

  source_image_marketplace_sku = local.image_properties_map[var.image_os].source_image_marketplace_sku
  os_disk_size_gb = coalesce(var.os_disk_size_gb, local.image_properties_map[var.image_os].os_disk_size_gb)
}
