packer {
  required_plugins {
    veertu-anka = {
      version = ">= v3.2.0"
      source  = "github.com/veertuinc/veertu-anka"
    }
  }
}

locals {
  image_folder = "/Users/${var.vm_username}/image-generation"
}

variable "builder_type" {
  type = string
  default = "veertu-anka-vm-clone"
  validation {
    condition = contains(["veertu-anka-vm-clone", "null"], var.builder_type)
    error_message = "The builder_type value must be one of [veertu-anka-vm-clone, null]."
  }
}

variable "source_vm_name" {
  type = string
}

variable "source_vm_port" {
  type = number
  default = 22
}

variable "source_vm_tag" {
  type = string
  default = ""
}

variable "socks_proxy" {
  type = string
  default = ""
}

variable "build_id" {
  type = string
}

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "github_api_pat" {
  type      = string
  sensitive = true
  default   = ""
}

variable "xcode_install_storage_url" {
  type      = string
  sensitive = true
}

variable "xcode_install_sas" {
  type      = string
  sensitive = true
}

variable "vcpu_count" {
  type    = string
  default = "6"
}

variable "ram_size" {
  type    = string
  default = "8G"
}

variable "image_os" {
  type    = string
  default = "macos26"
}

source "veertu-anka-vm-clone" "template" {
  vm_name        = "${var.build_id}"
  source_vm_name = "${var.source_vm_name}"
  source_vm_tag  = "${var.source_vm_tag}"
  vcpu_count     = "${var.vcpu_count}"
  ram_size       = "${var.ram_size}"
  stop_vm        = "true"
  log_level      = "debug"
}

source "null" "template" {
  ssh_host = "${var.source_vm_name}"
  ssh_port = "${var.source_vm_port}"
  ssh_username = "${var.vm_username}"
  ssh_password = "${var.vm_password}"
  ssh_proxy_host = "${var.socks_proxy}"
}

build {
  sources = ["source.${var.builder_type}.template"]

  provisioner "shell" {
    inline = ["mkdir ${local.image_folder}"]
  }

  provisioner "file" {
    destination = "${local.image_folder}/"
    sources     = [
      "${path.root}/../scripts/tests",
      "${path.root}/../scripts/docs-gen",
      "${path.root}/../scripts/helpers"
    ]
  }

  provisioner "file" {
    destination = "${local.image_folder}/docs-gen/"
    source      = "${path.root}/../../../helpers/software-report-base"
  }

  provisioner "file" {
    destination = "${local.image_folder}/add-certificate.swift"
    source      = "${path.root}/../assets/add-certificate.swift"
  }

  provisioner "file" {
    destination = ".bashrc"
    source      = "${path.root}/../assets/bashrc"
  }

  provisioner "file" {
    destination = ".bash_profile"
    source      = "${path.root}/../assets/bashprofile"
  }

  provisioner "shell" {
    inline = ["mkdir ~/bootstrap"]
  }

  provisioner "file" {
    destination = "bootstrap"
    source      = "${path.root}/../assets/bootstrap-provisioner/"
  }

  provisioner "file" {
    destination = "${local.image_folder}/toolset.json"
    source      = "${path.root}/../toolsets/toolset-26.json"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mv ${local.image_folder}/docs-gen ${local.image_folder}/software-report",
      "mkdir ~/utils",
      "mv ${local.image_folder}/helpers/invoke-tests.sh ~/utils",
      "mv ${local.image_folder}/helpers/utils.sh ~/utils"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "${path.root}/../scripts/build/install-xcode-clt.sh",
      "${path.root}/../scripts/build/install-homebrew.sh",
      "${path.root}/../scripts/build/install-rosetta.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["PASSWORD=${var.vm_password}", "USERNAME=${var.vm_username}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/configure-tccdb-macos.sh",
      "${path.root}/../scripts/build/configure-autologin.sh",
      "${path.root}/../scripts/build/configure-auto-updates.sh",
      "${path.root}/../scripts/build/configure-ntpconf.sh",
      "${path.root}/../scripts/build/configure-shell.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.build_id}", "IMAGE_OS=${var.image_os}", "PASSWORD=${var.vm_password}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/configure-preimagedata.sh",
      "${path.root}/../scripts/build/configure-ssh.sh",
      "${path.root}/../scripts/build/configure-machine.sh"
    ]
  }

  provisioner "shell" {
    execute_command   = "source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}", "USER_PASSWORD=${var.vm_password}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    pause_before     = "30s"
    scripts          = [
      "${path.root}/../scripts/build/configure-windows.sh",
      "${path.root}/../scripts/build/install-powershell.sh",
      "${path.root}/../scripts/build/install-dotnet.sh",
      "${path.root}/../scripts/build/install-python.sh",
      "${path.root}/../scripts/build/install-azcopy.sh",
      "${path.root}/../scripts/build/install-ruby.sh",
      "${path.root}/../scripts/build/install-rubygems.sh",
      "${path.root}/../scripts/build/install-git.sh",
      "${path.root}/../scripts/build/install-node.sh",
      "${path.root}/../scripts/build/install-common-utils.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["XCODE_INSTALL_STORAGE_URL=${var.xcode_install_storage_url}", "XCODE_INSTALL_SAS=${var.xcode_install_sas}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
    script           = "${path.root}/../scripts/build/Install-Xcode.ps1"
  }

  provisioner "shell" {
    execute_command   = "source $HOME/.bash_profile; sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/install-actions-cache.sh",
      "${path.root}/../scripts/build/install-runner-package.sh",
      "${path.root}/../scripts/build/install-llvm.sh",
      "${path.root}/../scripts/build/install-openjdk.sh",
      "${path.root}/../scripts/build/install-aws-tools.sh",
      "${path.root}/../scripts/build/install-rust.sh",
      "${path.root}/../scripts/build/install-gcc.sh",
      "${path.root}/../scripts/build/install-cocoapods.sh",
      "${path.root}/../scripts/build/install-android-sdk.sh",
      "${path.root}/../scripts/build/install-vcpkg.sh",
      "${path.root}/../scripts/build/install-safari.sh",
      "${path.root}/../scripts/build/install-chrome.sh",
      "${path.root}/../scripts/build/install-firefox.sh",
      "${path.root}/../scripts/build/install-bicep.sh",
      "${path.root}/../scripts/build/install-codeql-bundle.sh",
      "${path.root}/../scripts/build/install-edge.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/Install-Toolset.ps1",
      "${path.root}/../scripts/build/Configure-Toolset.ps1"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_FOLDER=${local.image_folder}"]
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} pwsh -f {{ .Path }}"
    script          = "${path.root}/../scripts/build/Configure-Xcode-Simulators.ps1"
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    inline           = [
      "pwsh -File \"${local.image_folder}/software-report/Generate-SoftwareReport.ps1\" -OutputDirectory \"${local.image_folder}/output/software-report\" -ImageName ${var.build_id}",
      "pwsh -File \"${local.image_folder}/tests/RunAll-Tests.ps1\""
    ]
  }

  provisioner "file" {
    destination = "${path.root}/../../image-output/"
    direction   = "download"
    source      = "${local.image_folder}/output/"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; source $HOME/.bash_profile; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "${path.root}/../scripts/build/configure-hostname.sh",
      "${path.root}/../scripts/build/configure-system.sh"
    ]
  }
}
