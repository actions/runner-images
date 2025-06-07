locals {
  image_properties    = var.image_os = "win19" ? {
                              publisher         = "MicrosoftWindowsServer"
                              offer             = "WindowsServer"
                              sku               = "2019-Datacenter"
                              os_disk_size_gb   = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 256
                        } : var.image_os = "win22" ? {
                              publisher         = "MicrosoftWindowsServer"
                              offer             = "WindowsServer"
                              sku               = "2022-Datacenter"
                              os_disk_size_gb   = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 256
                        } : {
                              publisher         = "MicrosoftWindowsServer"
                              offer             = "WindowsServer"
                              sku               = "2025-Datacenter"
                              os_disk_size_gb   = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 150
                      }
}
