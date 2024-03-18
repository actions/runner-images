packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

locals {
  image_folder = "/Users/${var.vm_username}/image-generation"
}

variable "baseimage_name" {
  type = string
}

variable "build_id" {
  type = string
}

variable "cluster_or_esxi_host" {
  type = string
}

variable "esxi_datastore" {
  type = string
}

variable "github_api_pat" {
  type      = string
  default   = ""
  sensitive = true
}

variable "image_os" {
  type    = string
  default = "macos11"
}

variable "output_folder" {
  type = string
}

variable "vcenter_datacenter" {
  type = string
}

variable "vcenter_password" {
  type      = string
  sensitive = true
}

variable "vcenter_server" {
  type = string
}

variable "vcenter_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "xcode_install_sas" {
  type      = string
  sensitive = true
}

variable "xcode_install_storage_url" {
  type      = string
  sensitive = true
}

source "vsphere-clone" "template" {
  CPUs                = "5"
  NestedHV            = "true"
  RAM                 = "24576"
  cpu_cores           = "5"
  datacenter          = "${var.vcenter_datacenter}"
  datastore           = "${var.esxi_datastore}"
  folder              = "${var.output_folder}"
  host                = "${var.cluster_or_esxi_host}"
  insecure_connection = true
  password            = "${var.vcenter_password}"
  shutdown_timeout    = "15m"
  ssh_password        = "${var.vm_password}"
  ssh_username        = "${var.vm_username}"
  template            = "${var.baseimage_name}"
  username            = "${var.vcenter_username}"
  vcenter_server      = "${var.vcenter_server}"
  vm_name             = "${var.build_id}"
}

build {
  sources = ["source.vsphere-clone.template"]

  provisioner "shell" {
    inline = ["mkdir ${local.image_folder}"]
  }

  provisioner "file" {
    destination = "${local.image_folder}/"
    sources     = [
      "${path.root}/../assets/xamarin-selector",
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
    destination = "~/.bashrc"
    source      = "${path.root}/../assets/bashrc"
  }

  provisioner "file" {
    destination = "~/.bash_profile"
    source      = "${path.root}/../assets/bashprofile"
  }

  provisioner "shell" {
    inline = [ "mkdir ~/bootstrap" ]
  }

  provisioner "file" {
    destination = "~/bootstrap"
    source      = "${path.root}/../assets/bootstrap-provisioner/"
  }

  provisioner "file" {
    destination = "${local.image_folder}/toolset.json"
    source      = "${path.root}/../toolsets/toolset-11.json"
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mv ${local.image_folder}/docs-gen ${local.image_folder}/software-report",
      "mv ${local.image_folder}/xamarin-selector ${local.image_folder}/assets",
      "mkdir ~/utils",
      "mv ${local.image_folder}/helpers/confirm-identified-developers.scpt ~/utils",
      "mv ${local.image_folder}/helpers/invoke-tests.sh ~/utils",
      "mv ${local.image_folder}/helpers/utils.sh ~/utils",
      "mv ${local.image_folder}/helpers/xamarin-utils.sh ~/utils"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "${path.root}/../scripts/build/install-xcode-clt.sh",
      "${path.root}/../scripts/build/install-homebrew.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["PASSWORD=${var.vm_password}", "USERNAME=${var.vm_username}"]
    execute_command  = "chmod +x {{ .Path }}; sudo {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/install-xcode-clt.sh",
      "${path.root}/../scripts/build/configure-network-interface-detection.sh",
      "${path.root}/../scripts/build/configure-autologin.sh",
      "${path.root}/../scripts/build/configure-auto-updates.sh",
      "${path.root}/../scripts/build/configure-screensaver.sh",
      "${path.root}/../scripts/build/configure-ntpconf.sh",
      "${path.root}/../scripts/build/configure-max-files-limitation.sh",
      "${path.root}/../scripts/build/configure-shell.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_VERSION=${var.build_id}", "IMAGE_OS=${var.image_os}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/configure-preimagedata.sh",
      "${path.root}/../scripts/build/configure-ssh.sh",
      "${path.root}/../scripts/build/configure-machine.sh"
    ]
  }

  provisioner "shell" {
    execute_command   = "sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    pause_before     = "30s"
    scripts          = [
      "${path.root}/../scripts/build/configure-windows.sh",
      "${path.root}/../scripts/build/install-powershell.sh",
      "${path.root}/../scripts/build/install-dotnet.sh",
      "${path.root}/../scripts/build/install-python.sh",
      "${path.root}/../scripts/build/install-azcopy.sh",
      "${path.root}/../scripts/build/install-openssl.sh",
      "${path.root}/../scripts/build/install-ruby.sh",
      "${path.root}/../scripts/build/install-rubygems.sh",
      "${path.root}/../scripts/build/install-git.sh",
      "${path.root}/../scripts/build/install-mongodb.sh",
      "${path.root}/../scripts/build/install-node.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["XCODE_INSTALL_STORAGE_URL=${var.xcode_install_storage_url}", "XCODE_INSTALL_SAS=${var.xcode_install_sas}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} pwsh -f {{ .Path }}"
    script           = "${path.root}/../scripts/build/Install-Xcode.ps1"
  }

  provisioner "shell" {
    execute_command   = "sudo {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    inline            = ["echo 'Reboot VM'", "shutdown -r now"]
  }

  provisioner "shell" {
    environment_vars = ["API_PAT=${var.github_api_pat}", "IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/install-actions-cache.sh",
      "${path.root}/../scripts/build/install-common-utils.sh",
      "${path.root}/../scripts/build/install-llvm.sh",
      "${path.root}/../scripts/build/install-golang.sh",
      "${path.root}/../scripts/build/install-swiftlint.sh",
      "${path.root}/../scripts/build/install-openjdk.sh",
      "${path.root}/../scripts/build/install-aws-tools.sh",
      "${path.root}/../scripts/build/install-gcc.sh",
      "${path.root}/../scripts/build/install-haskell.sh",
      "${path.root}/../scripts/build/install-cocoapods.sh",
      "${path.root}/../scripts/build/install-android-sdk.sh",
      "${path.root}/../scripts/build/install-xamarin.sh",
      "${path.root}/../scripts/build/install-visualstudio.sh",
      "${path.root}/../scripts/build/install-nvm.sh",
      "${path.root}/../scripts/build/install-apache.sh",
      "${path.root}/../scripts/build/install-nginx.sh",
      "${path.root}/../scripts/build/install-postgresql.sh",
      "${path.root}/../scripts/build/install-audiodevice.sh",
      "${path.root}/../scripts/build/install-vcpkg.sh",
      "${path.root}/../scripts/build/install-miniconda.sh",
      "${path.root}/../scripts/build/install-safari.sh",
      "${path.root}/../scripts/build/install-chrome.sh",
      "${path.root}/../scripts/build/install-edge.sh",
      "${path.root}/../scripts/build/install-firefox.sh",
      "${path.root}/../scripts/build/install-pypy.sh",
      "${path.root}/../scripts/build/install-pipx-packages.sh",
      "${path.root}/../scripts/build/install-bicep.sh",
      "${path.root}/../scripts/build/install-codeql-bundle.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_FOLDER=${local.image_folder}"]
    execute_command  = "chmod +x {{ .Path }}; {{ .Vars }} pwsh -f {{ .Path }}"
    scripts          = [
      "${path.root}/../scripts/build/Install-Toolset.ps1",
      "${path.root}/../scripts/build/Configure-Toolset.ps1"
    ]
  }

  provisioner "shell" {
    execute_command = "ruby {{ .Path }}"
    script          = "${path.root}/../scripts/build/configure-xcode-simulators.rb"
  }

  provisioner "shell" {
    environment_vars = ["IMAGE_FOLDER=${local.image_folder}"]
    inline           = [
      "pwsh -File \"${local.image_folder}/software-report/Generate-SoftwareReport.ps1\" -OutputDirectory \"${local.image_folder}/output/software-report\" -ImageName ${var.build_id}",
      "pwsh -File \"${local.image_folder}/tests/RunAll-Tests.ps1\""
    ]
  }

  provisioner "file" {
    destination = "${path.root}/../../image-output/"
    direction   = "download"
    source      = "${local.image_folder}/output/*"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}"
    scripts         = [
      "${path.root}/../scripts/build/configure-hostname.sh",
      "${path.root}/../scripts/build/configure-system.sh"
    ]
  }
}
