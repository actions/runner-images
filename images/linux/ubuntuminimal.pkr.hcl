locals {
  image_os = "ubuntu22"

  toolset_file_name = "toolset-2204.json"

  image_folder            = "/imagegeneration"
  helper_script_folder    = "/imagegeneration/helpers"
  installer_script_folder = "/imagegeneration/installers"
  imagedata_file          = "/imagegeneration/imagedata.json"
}

variable "allowed_inbound_ip_addresses" {
  type    = list(string)
  default = []
}

variable "azure_tags" {
  type    = map(string)
  default = {}
}

variable "build_resource_group_name" {
  type    = string
  default = "${env("BUILD_RESOURCE_GROUP_NAME")}"
}

variable "capture_name_prefix" {
  type    = string
  default = "packer"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type      = string
  default   = "${env("ARM_CLIENT_SECRET")}"
  sensitive = true
}

variable "client_cert_path" {
  type      = string
  default   = "${env("ARM_CLIENT_CERT_PATH")}"
}

variable "commit_url" {
  type      = string
  default   = ""
}

variable "image_version" {
  type    = string
  default = "dev"
}

variable "install_password" {
  type  = string
  default = ""
}

variable "location" {
  type    = string
  default = "${env("ARM_RESOURCE_LOCATION")}"
}

variable "private_virtual_network_with_public_ip" {
  type    = bool
  default = false
}

variable "resource_group" {
  type    = string
  default = "${env("ARM_RESOURCE_GROUP")}"
}

variable "run_validation_diskspace" {
  type    = bool
  default = false
}

variable "storage_account" {
  type    = string
  default = "${env("ARM_STORAGE_ACCOUNT")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "temp_resource_group_name" {
  type    = string
  default = "${env("TEMP_RESOURCE_GROUP_NAME")}"
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "virtual_network_name" {
  type    = string
  default = "${env("VNET_NAME")}"
}

variable "virtual_network_resource_group_name" {
  type    = string
  default = "${env("VNET_RESOURCE_GROUP")}"
}

variable "virtual_network_subnet_name" {
  type    = string
  default = "${env("VNET_SUBNET")}"
}

variable "vm_size" {
  type    = string
  default = "Standard_D4s_v4"
}

source "azure-arm" "build_vhd" {
  location = "${var.location}"

  // Auth
  tenant_id        = "${var.tenant_id}"
  subscription_id  = "${var.subscription_id}"
  client_id        = "${var.client_id}"
  client_secret    = "${var.client_secret}"
  client_cert_path = "${var.client_cert_path}"

  // Base image
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_publisher = "canonical"
  image_sku       = "22_04-lts"

  // Target location
  storage_account        = "${var.storage_account}"
  resource_group_name    = "${var.resource_group}"
  capture_container_name = "images"
  capture_name_prefix    = "${var.capture_name_prefix}"

  // Resource group for VM
  build_resource_group_name = "${var.build_resource_group_name}"
  temp_resource_group_name  = "${var.temp_resource_group_name}"

  // Networking for VM
  private_virtual_network_with_public_ip = "${var.private_virtual_network_with_public_ip}"
  virtual_network_resource_group_name    = "${var.virtual_network_resource_group_name}"
  virtual_network_name                   = "${var.virtual_network_name}"
  virtual_network_subnet_name            = "${var.virtual_network_subnet_name}"
  allowed_inbound_ip_addresses           = "${var.allowed_inbound_ip_addresses}"
  
  // VM Configuration
  vm_size         = "${var.vm_size}"
  os_disk_size_gb = "86"
  os_type         = "Linux"
  
  dynamic "azure_tag" {
    for_each = var.azure_tags
    content {
      name = azure_tag.key
      value = azure_tag.value
    }
  }
}

build {
  sources = ["source.azure-arm.build_vhd"]

  // Create folder to store temporary data
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["mkdir ${local.image_folder}",
                       "chmod 777 ${local.image_folder}"]
  }

  // Add apt wrapper to implement retries
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/apt-mock.sh"
  }

  // Install MS package repos
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/base/repos.sh"]
  }

  // Configure apt
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script           = "${path.root}/scripts/base/apt.sh"
  }

  // Configure limits
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/limits.sh"
  }

  provisioner "file" {
    destination = "${local.helper_script_folder}"
    source      = "${path.root}/scripts/helpers"
  }

  provisioner "file" {
    destination = "${local.installer_script_folder}"
    source      = "${path.root}/scripts/installers"
  }

  provisioner "file" {
    destination = "${local.image_folder}"
    sources     = [
      "${path.root}/post-generation",
      "${path.root}/scripts/tests"
    ]
  }

  provisioner "file" {
    destination = "${local.installer_script_folder}/toolset.json"
    source      = "${path.root}/toolsets/${local.toolset_file_name}"
  }

  // Generate image data file
  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGEDATA_FILE=${local.imagedata_file}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/preimagedata.sh"]
  }

  // Create /etc/environment, configure waagent etc.
  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.image_version}", "IMAGE_OS=${local.image_os}", "HELPER_SCRIPTS=${local.helper_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/configure-environment.sh"]
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive", "HELPER_SCRIPTS=${local.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${local.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/apt-vital.sh"]
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive", "HELPER_SCRIPTS=${local.helper_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/powershellcore.sh"]
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPTS=${local.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${local.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} pwsh -f {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/Install-PowerShellModules.ps1"]
  }

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive", "HELPER_SCRIPTS=${local.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${local.installer_script_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
                        "${path.root}/scripts/installers/git.sh",
                        "${path.root}/scripts/installers/github-cli.sh",
                        "${path.root}/scripts/installers/zstd.sh"
    ]
  }

  provisioner "shell" {
    execute_command   = "/bin/sh -c '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    scripts           = ["${path.root}/scripts/base/reboot.sh"]
  }

  provisioner "shell" {
    execute_command     = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    pause_before        = "1m0s"
    scripts             = ["${path.root}/scripts/installers/cleanup.sh"]
    start_retry_timeout = "10m"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${path.root}/scripts/base/apt-mock-remove.sh"
  }

  provisioner "shell" {
    environment_vars = ["HELPER_SCRIPT_FOLDER=${local.helper_script_folder}", "INSTALLER_SCRIPT_FOLDER=${local.installer_script_folder}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = ["${path.root}/scripts/installers/post-deployment.sh"]
  }

  provisioner "shell" {
    environment_vars = ["RUN_VALIDATION=${var.run_validation_diskspace}"]
    scripts          = ["${path.root}/scripts/installers/validate-disk-space.sh"]
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = ["sleep 30", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
  }

}
