locals {
  image_properties    = var.image_sku == "2019-Datacenter" ? {
                            image_os = "win19"
                            os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 256
                      } : var.image_sku == "2022-Datacenter" ? {
                            image_os = "win22"
                            os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 256
                      } : {
                            image_os = "win25"
                            os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 150
                      }
}
