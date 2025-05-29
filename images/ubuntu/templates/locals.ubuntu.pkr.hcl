locals {
  image_properties    = var.image_sku == "22_04-lts" ? {
                            image_os = "ubuntu22"
                            os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 75
                      } : {
                            image_os = "ubuntu24"
                            os_disk_size_gb = var.os_disk_size_gb != 0 ? var.os_disk_size_gb : 75
                      }
}

// Define local variables for the ubuntu-minimal build
locals {
  ubuntu_minimal_image_os = "ubuntu22"

  toolset_file_name = "toolset-2204.json"

  image_folder            = "/imagegeneration"
  helper_script_folder    = "/imagegeneration/helpers"
  installer_script_folder = "/imagegeneration/installers"
  imagedata_file          = "/imagegeneration/imagedata.json"
}
