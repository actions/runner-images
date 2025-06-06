locals {
  image_properties    = var.image_os = "ubuntu22" ? {
                              publisher       = "canonical"
                              offer           = "0001-com-ubuntu-server-jammy"
                              sku             = "22_04-lts"
                              os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 75
                        } : var.image_os = "ubuntu24" ? {
                              publisher       = "canonical"
                              offer           = "ubuntu-24_04-lts"
                              sku             = "server-gen1"
                              os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 75
                        }
}
