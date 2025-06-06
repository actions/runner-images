locals {
    image_properties_map = {
      "win19" = {
            publisher         = "MicrosoftWindowsServer"
            offer             = "WindowsServer"
            sku               = "2019-Datacenter"
            os_disk_size_gb = coalesce(var.os_disk_size_gb, 256)
      },
      "win22" = {
            publisher         = "MicrosoftWindowsServer"
            offer             = "WindowsServer"
            sku               = "2022-Datacenter"
            os_disk_size_gb = coalesce(var.os_disk_size_gb, 256)
      },
      "win25" = {
            publisher         = "MicrosoftWindowsServer"
            offer             = "WindowsServer"
            sku               = "2025-Datacenter"
            os_disk_size_gb = coalesce(var.os_disk_size_gb, 150)
      }
  }

  image_properties = local.image_properties_map[var.image_os]
}
